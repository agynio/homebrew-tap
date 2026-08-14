class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.18.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.18.0/agyn_v0.18.0_darwin_arm64.tar.gz"
      sha256 "ac37c72cfbc7e5cbcfb76b6694a27262f1b1d40f5c4825fa5f2af0866ddc699f"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.18.0/agyn_v0.18.0_darwin_amd64.tar.gz"
      sha256 "f96a698b0aadc4a6ff2b6907555142df93019db8f1783f9d9fa00ae506137852"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.18.0/agyn_v0.18.0_linux_arm64.tar.gz"
      sha256 "315e90a1b624abee2b75b804fb12f906d6e59ff0f947f3e47f2935ba1c2f5880"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.18.0/agyn_v0.18.0_linux_amd64.tar.gz"
      sha256 "6b77bbfcbbcc57c2f8b2e6f2286db3565e9c8fc102328c307cb8abc78686507f"
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
