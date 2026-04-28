# typed: false
# frozen_string_literal: true

class Aerogesture < Formula
  desc "CLI daemon for trackpad swipe gestures to switch AeroSpace workspaces"
  homepage "https://github.com/derangga/aerogesture"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/derangga/aerogesture/releases/download/v0.1.0/aerogesture_0.1.0_macos_arm64.tar.gz"
      sha256 "ea88a067e947819d530432df6661e0d354d40c3083bfac1c1f8f8e1ded762463"
    end
    if Hardware::CPU.intel?
      url "https://github.com/derangga/aerogesture/releases/download/v0.1.0/aerogesture_0.1.0_macos_x86_64.tar.gz"
      sha256 "ef521cb9f7868aabf409ea91f46fa3b8f853278d9e9bfc609c4fd69db38aa17d"
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
