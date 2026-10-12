# typed: false
# frozen_string_literal: true

class Aerogesture < Formula
  desc "CLI daemon for trackpad swipe gestures to switch AeroSpace workspaces"
  homepage "https://github.com/derangga/aerogesture"
  version "0.3.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/derangga/aerogesture/releases/download/v0.3.0/aerogesture_0.3.0_macos_arm64.tar.gz"
      sha256 "618cba54577cab0699397dc0619843b5ddba7007299eb65ac24e14b92276d923"
    end
    if Hardware::CPU.intel?
      url "https://github.com/derangga/aerogesture/releases/download/v0.3.0/aerogesture_0.3.0_macos_x86_64.tar.gz"
      sha256 "e5a1dc64d321ff89ca1f2b82335f69dfe17f9d41a648871413f2836da62c58c2"
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
