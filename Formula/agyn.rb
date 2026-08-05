class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.2.22"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.22/agyn_v0.2.22_darwin_arm64.tar.gz"
      sha256 "abe454306be3cab6e905b908b15d5384acbb0d4d37035ee0c5316d672581e0b5"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.22/agyn_v0.2.22_darwin_amd64.tar.gz"
      sha256 "ea5e8fff154fbc9937f422dadf5fd51cdac3186a68ad7aaa10373c49dfadeedd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.22/agyn_v0.2.22_linux_arm64.tar.gz"
      sha256 "204e29c3d857951b0ff811b985c80c7a10bd71d9452382693f44e2be0e0fec6d"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.22/agyn_v0.2.22_linux_amd64.tar.gz"
      sha256 "836c5d571c5a9a31cd9687955257a2ea1d41d4c29e56c0b0710821d9256dede5"
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
