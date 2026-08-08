class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.3.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.3/agyn_v0.3.3_darwin_arm64.tar.gz"
      sha256 "b65aa246534658e72b3e8bf8599218abe6a11ef28e8160fa9528a9b0b7ed5a89"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.3/agyn_v0.3.3_darwin_amd64.tar.gz"
      sha256 "9e2664bc358017b481db778549795ac68cf06cf5fdf708a30f401574be1b5e42"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.3/agyn_v0.3.3_linux_arm64.tar.gz"
      sha256 "a209691a1cf7ad27f7002ee07a4dc940e7927fb713fe52daa6bb58b192c629b2"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.3/agyn_v0.3.3_linux_amd64.tar.gz"
      sha256 "eda4c747e037a0cb58a8aecea8892cc97801788fc510cf7d6b0ec399ccd2d8a6"
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
