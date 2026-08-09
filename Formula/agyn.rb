class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.5.0/agyn_v0.5.0_darwin_arm64.tar.gz"
      sha256 "f2f57167a141a15872ffefb4cdc1e5c9661891622264a20d85db7f2dd4c386c7"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.5.0/agyn_v0.5.0_darwin_amd64.tar.gz"
      sha256 "7647e6ff59940da20464d9ba660ad9a7191ae1266b7f45e8ae13de09d9102fa9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.5.0/agyn_v0.5.0_linux_arm64.tar.gz"
      sha256 "2293ddb4c39281f9a1f34f67b43d7191d0eae2401046902b366c658a56f98efa"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.5.0/agyn_v0.5.0_linux_amd64.tar.gz"
      sha256 "54eacbff82a4f39167506a2e11515704f553ef2bb19692dd0dbd840c2377b45b"
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
