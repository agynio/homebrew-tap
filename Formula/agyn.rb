class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.6.0/agyn_v0.6.0_darwin_arm64.tar.gz"
      sha256 "a62bd4db2811f06e341943d4e5db1fafa9c1c6eb22c8edcca7359edb5bd2cf8d"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.6.0/agyn_v0.6.0_darwin_amd64.tar.gz"
      sha256 "b8500e70ab9b5497860eac0c39a6e91e8b1de04d4c8e44d0cfdba4083024a13f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.6.0/agyn_v0.6.0_linux_arm64.tar.gz"
      sha256 "c758c0babad10260994a614e2e9fc102b89fc578ca30a3f18b0cac5f17cc7354"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.6.0/agyn_v0.6.0_linux_amd64.tar.gz"
      sha256 "8dc2f696b2cee52f02d2cb5eb7bcc4b850bfc8da4de88c2f918001f3b9d0a30a"
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
