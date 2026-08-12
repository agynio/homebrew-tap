class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.17.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.17.0/agyn_v0.17.0_darwin_arm64.tar.gz"
      sha256 "8bb078677d5183971d944f0da29e36976c12ec3a02f61558643b7e5b9f8dfe36"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.17.0/agyn_v0.17.0_darwin_amd64.tar.gz"
      sha256 "220592630755a392284f5832cc0caf0a04ac7b24ae8da8980bff0ba9256e98b0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.17.0/agyn_v0.17.0_linux_arm64.tar.gz"
      sha256 "4cbcb64f00052ebc9c7d69bbc8f5a1069ba8407b2bb969f748db7c2e6675bfef"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.17.0/agyn_v0.17.0_linux_amd64.tar.gz"
      sha256 "38f667e0c6beb4e89ea35dd84351f23188edd41542dacf995891bc8f542168fa"
    end
  end

  def install
    bin.install "agyn"
  end

  # `agyn local` additionally needs limactl, qemu and xz. They are not
  # formula dependencies: most of that is a large install, and someone
  # using agyn against a remote cluster needs none of it.
  # `agyn local doctor` reports what is missing and how to get it.
  def caveats
    <<~EOS
      To run the local platform VM, install its dependencies:
        brew install lima xz
      Then check the environment with:
        agyn local doctor
    EOS
  end

  test do
    assert_match "agyn version", shell_output("#{bin}/agyn --version")
  end
end
