class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.0/agyn_v0.3.0_darwin_arm64.tar.gz"
      sha256 "53f2224ff1b1ce32b7314bf792f53201d3e8117892a901fdd5cbbf8803987119"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.0/agyn_v0.3.0_darwin_amd64.tar.gz"
      sha256 "e9148cd8ddcf16fa10e7d7c8c4ab3d39f9e237f4005b46995bf9704a056a62b3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.0/agyn_v0.3.0_linux_arm64.tar.gz"
      sha256 "d29599eea313052d3b4fbeea1f53347add2c15ac7f18fd44be01d400e49dbcdb"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.0/agyn_v0.3.0_linux_amd64.tar.gz"
      sha256 "33c160c721e180dba8401670ac1dc37a5af7bd1312c32c9050262490d4609f00"
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
