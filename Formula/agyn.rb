class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.15.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.15.0/agyn_v0.15.0_darwin_arm64.tar.gz"
      sha256 "42784269d0d0ef3488737a8e0e68edfda863be545abf5a87b33fa4669a1c1d8a"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.15.0/agyn_v0.15.0_darwin_amd64.tar.gz"
      sha256 "c4ae9eb5aa27b5f82b4390c1c824a559edd891b0e6f80f851310eacf1c63d9b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.15.0/agyn_v0.15.0_linux_arm64.tar.gz"
      sha256 "45b32cb2d66e1bbd521029d1927f3acea9f59ce0c35b96692e2b61568f5bd798"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.15.0/agyn_v0.15.0_linux_amd64.tar.gz"
      sha256 "b1090a84e76d6f056dd8bfc3f4c8b84ba806bccee7fac2205b01728688a4aa3d"
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
