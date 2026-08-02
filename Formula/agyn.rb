class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.2.19"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.19/agyn_v0.2.19_darwin_arm64.tar.gz"
      sha256 "c27a852974ce6e98fb8ff90bc7b17f20de862f575a96421cd934ef6bc2d8fc03"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.19/agyn_v0.2.19_darwin_amd64.tar.gz"
      sha256 "7c5e8b99b3ba76f5fecd20b06f9140cf1fa253e0c7adc23488f9230a932975d1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.19/agyn_v0.2.19_linux_arm64.tar.gz"
      sha256 "7b6135de2efeb7c493894bf8d81279b06df922ad63446acc1bb103304fb7fe07"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.19/agyn_v0.2.19_linux_amd64.tar.gz"
      sha256 "23a98425a3b72a6d7a709e0130e23ab79fe12be600024063f2c239ea47db947a"
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
