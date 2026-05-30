class OutlineCli < Formula
  desc "CLI for Outline (self-hosted-focused)"
  homepage "https://github.com/agynio/outline-cli"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/outline-cli/releases/download/v0.2.1/outline_v0.2.1_darwin_arm64.tar.gz"
      sha256 "de93d179df4483120768270b7fbdbbbf5487ee24523fe0e54e7b8e11e35b4275"
    else
      url "https://github.com/agynio/outline-cli/releases/download/v0.2.1/outline_v0.2.1_darwin_amd64.tar.gz"
      sha256 "9f8abd52b69cbf5912244fc21cb36b3e94f6be1bd52c730ce7eeeadd63481ca2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/outline-cli/releases/download/v0.2.1/outline_v0.2.1_linux_arm64.tar.gz"
      sha256 "c9610b60229b9e697d86b63f85779f4b82ebd4a46396c6e9492b26193725b800"
    else
      url "https://github.com/agynio/outline-cli/releases/download/v0.2.1/outline_v0.2.1_linux_amd64.tar.gz"
      sha256 "1926024f9ce18d40aae8e41c249eb666c9329bd070553c46328a2c83ad3903ce"
    end
  end

  def install
    bin.install "outline"
  end

  test do
    assert_match "outline version", shell_output("#{bin}/outline --version")
  end
end
