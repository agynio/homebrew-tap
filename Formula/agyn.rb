class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.18.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.18.1/agyn_v0.18.1_darwin_arm64.tar.gz"
      sha256 "443a34da761cf4c0becc58963c2e9b8dd8e12fbc58dcfe3a9f576ec42105a851"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.18.1/agyn_v0.18.1_darwin_amd64.tar.gz"
      sha256 "a996349d0b7a4c8f7b9cc3bf17d331c9e9c0e622a5aad3ce7c58ac9f03a27585"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.18.1/agyn_v0.18.1_linux_arm64.tar.gz"
      sha256 "6a44244f4b822aaeb7542eb36542efed75f13cb8712be91c6ea1ec0bcec2f128"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.18.1/agyn_v0.18.1_linux_amd64.tar.gz"
      sha256 "783c08712ae91aa20dce9a14bf158af703337d2a0367fece43d6d7382fa22a7c"
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
