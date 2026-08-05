class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.2.21"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.21/agyn_v0.2.21_darwin_arm64.tar.gz"
      sha256 "5f6bbc9d0650f045c507b980947ca7c8edb648c0bd6731e4469ba24c9b827bef"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.21/agyn_v0.2.21_darwin_amd64.tar.gz"
      sha256 "c87cd60d552056e696f5a824a7f17fa1071caf3c0dc2758a64276a640883d9e7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.21/agyn_v0.2.21_linux_arm64.tar.gz"
      sha256 "5661d2abc66123185f84a77a72a2de7df47476793ec720d8532196254c6a63ed"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.21/agyn_v0.2.21_linux_amd64.tar.gz"
      sha256 "a5cbac7f3a781be98f8308ea350ce9e8010eb64f07bb35f64656fdbacbfbffba"
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
