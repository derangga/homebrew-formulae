# typed: false
# frozen_string_literal: true

class Aerogesture < Formula
  desc "CLI daemon for trackpad swipe gestures to switch AeroSpace workspaces"
  homepage "https://github.com/derangga/aerogesture"
  version "0.1.2"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/derangga/aerogesture/releases/download/v0.1.2/aerogesture_0.1.2_macos_arm64.tar.gz"
      sha256 "b86e49176478256c70790ab9d1364101d70b1ee5b8e1da11c841dba7fddec4b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/derangga/aerogesture/releases/download/v0.1.2/aerogesture_0.1.2_macos_x86_64.tar.gz"
      sha256 "0661471c036c5fd3b5de59e81001e6143d6ee9bf39684f6df84ce2d708244701"
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
