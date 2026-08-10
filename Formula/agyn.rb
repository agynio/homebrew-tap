class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.16.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.16.0/agyn_v0.16.0_darwin_arm64.tar.gz"
      sha256 "a11d73de68a7c7baea7b7840d697e3713e6f3a199e372bdc51c317dcfae6587f"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.16.0/agyn_v0.16.0_darwin_amd64.tar.gz"
      sha256 "c73c3bd569e181440714203fe7ef0da59a50b49f4a77183da2bac77acf9b8262"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.16.0/agyn_v0.16.0_linux_arm64.tar.gz"
      sha256 "b019a1ffbad0b2230dc5766fa536c5a0d05b1ed76b2f7b29f2038bfa821349f9"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.16.0/agyn_v0.16.0_linux_amd64.tar.gz"
      sha256 "e302de202f88defaf44868f9b2d7e406da719c1666e171062922fb4b9c9e1767"
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
