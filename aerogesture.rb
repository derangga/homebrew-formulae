# typed: false
# frozen_string_literal: true

class Aerogesture < Formula
  desc "CLI daemon for trackpad swipe gestures to switch AeroSpace workspaces"
  homepage "https://github.com/derangga/aerogesture"
  version "0.1.1"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/derangga/aerogesture/releases/download/v0.1.1/aerogesture_0.1.1_macos_arm64.tar.gz"
      sha256 "74acd2c3191fcfefa4d0d3fbf60b1b0617f94e0d1bb0a5edef8145fc9d7ca917"
    end
    if Hardware::CPU.intel?
      url "https://github.com/derangga/aerogesture/releases/download/v0.1.1/aerogesture_0.1.1_macos_x86_64.tar.gz"
      sha256 "d2485d6d317e9491caf434f339585873697735c74e02a1041666d96ba1becc7a"
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
