# typed: false
# frozen_string_literal: true

# Homebrew formula for Opaque — approval-gated secrets broker for AI coding tools
class Opaque < Formula
  desc "Approval-gated secrets broker for AI coding tools"
  homepage "https://github.com/opaque-dev/opaque"
  license "BUSL-1.1"

  on_macos do
    on_arm do
      url "https://github.com/opaque-dev/opaque/releases/download/v0.5.0/opaque-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "8e3ed63a68e5bdb01bd543377db1358cad93aaa3ddaec4d78119d7102154c757"
    end

    on_intel do
      url "https://github.com/opaque-dev/opaque/releases/download/v0.5.0/opaque-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "0a0ac0adbf3bac8e59f843df0301c4517e36fde08e1426547b02f27287588649"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/opaque-dev/opaque/releases/download/v0.5.0/opaque-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "35ee03cfb956f2809133f23b3372b338cbb43ee0504757b9296e4da057e5de48"
    end

    on_intel do
      url "https://github.com/opaque-dev/opaque/releases/download/v0.5.0/opaque-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fca696efa7941081baf87b302c7ffc977c86ed83ef3da729a4a39a7b70306336"
    end
  end

  def install
    bin.install "opaqued"
    bin.install "opaque"
    bin.install "opaque-mcp"
    bin.install "opaque-approve-helper"
    bin.install "opaque-web"
    # Older tagged archives predate these tools. A release containing them must
    # make them available without breaking installation of the existing tags.
    bin.install "opaque-mcp-contract" if File.file?("opaque-mcp-contract")
    bin.install "opaque-approver" if File.file?("opaque-approver")
    bin.install "opaque-evidence" if File.file?("opaque-evidence")
    prefix.install "Opaque Reviewer.app" if OS.mac? && File.directory?("Opaque Reviewer.app")
  end

  def caveats
    return unless OS.mac? && (prefix/"Opaque Reviewer.app").directory?

    <<~EOS
      The trusted reviewer is available at:
        #{prefix}/Opaque Reviewer.app
      Follow its enrollment guide before reviewing work:
        https://github.com/opaque-dev/opaque/blob/main/crates/opaque-approver/README.md
      Installing the formula does not enroll a broker or register a notice handler.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opaque --version")
  end
end
