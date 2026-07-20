class OutlineCli < Formula
  desc "CLI for Outline (self-hosted-focused)"
  homepage "https://github.com/agynio/outline-cli"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/outline-cli/releases/download/v0.4.0/outline_v0.4.0_darwin_arm64.tar.gz"
      sha256 "844b4fda204c1a35efe7eeddc90ca03cc649fa33f8081ea61c781a95b2f2936f"
    else
      url "https://github.com/agynio/outline-cli/releases/download/v0.4.0/outline_v0.4.0_darwin_amd64.tar.gz"
      sha256 "e94c7e2c2e10be388ac7a06da82633b519886ac21c18f6e74e6a7791ebd686d1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/outline-cli/releases/download/v0.4.0/outline_v0.4.0_linux_arm64.tar.gz"
      sha256 "59e4e11992cc27a2a8b5f1b7d91584b651c3f63e2acd46f9d5ab8bcec09a14aa"
    else
      url "https://github.com/agynio/outline-cli/releases/download/v0.4.0/outline_v0.4.0_linux_amd64.tar.gz"
      sha256 "c196929400d728cf0832755afd2baa50c5d1e7b421b943206fc7e139e42cfaa3"
    end
  end

  def install
    bin.install "outline"
  end

  test do
    assert_match "outline version", shell_output("#{bin}/outline --version")
  end
end
