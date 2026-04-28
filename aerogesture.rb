# typed: false
# frozen_string_literal: true

class Aerogesture < Formula
  desc "CLI daemon for trackpad swipe gestures to switch AeroSpace workspaces"
  homepage "https://github.com/derangga/aerospacegesture"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/derangga/aerospacegesture/releases/download/v0.1.0/aerogesture_0.1.0_macos_arm64.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/derangga/aerospacegesture/releases/download/v0.1.0/aerogesture_0.1.0_macos_x86_64.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
