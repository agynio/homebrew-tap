class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.1/agyn_v0.3.1_darwin_arm64.tar.gz"
      sha256 "2d3899f2e31df726af41c54c2ea6b42e8200e95969e6c75de723edd8d10b7c97"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.1/agyn_v0.3.1_darwin_amd64.tar.gz"
      sha256 "6458a933c304a08cfffcd6a716451684ae98865c82f711c64b924f4d1902366b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.1/agyn_v0.3.1_linux_arm64.tar.gz"
      sha256 "9df62c4a3590851be2161d9f0f6763b12dfe4a462ab1b9ba6f6da44c34604053"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.1/agyn_v0.3.1_linux_amd64.tar.gz"
      sha256 "a2d81171426c8dfc9997facb5d560b91f778b8b4b2250e3932d988fd054385f5"
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
