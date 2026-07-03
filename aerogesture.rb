# typed: false
# frozen_string_literal: true

class Aerogesture < Formula
  desc "CLI daemon for trackpad swipe gestures to switch AeroSpace workspaces"
  homepage "https://github.com/derangga/aerogesture"
  version "0.2.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/derangga/aerogesture/releases/download/v0.2.0/aerogesture_0.2.0_macos_arm64.tar.gz"
      sha256 "db14f2bd310cdd0ab6da9f146711c35a5caeb9b42f885f83f9da567b0ea093b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/derangga/aerogesture/releases/download/v0.2.0/aerogesture_0.2.0_macos_x86_64.tar.gz"
      sha256 "20879c60d6b565b7643f4d32ba31d7a8c963978aa38d0dd8718df21f3aaacc6e"
    end
  end

  def install
    bin.install "aerogesture"
  end

  service do
    run [opt_bin/"aerogesture"]
    keep_alive true
    log_path var/"log/aerogesture.stdout.log"
    error_log_path var/"log/aerogesture.stderr.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aerogesture --version")
  end
end
