class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.4.0/agyn_v0.4.0_darwin_arm64.tar.gz"
      sha256 "439e38cf0ce2077890098884c9f5b775e206d8b45b550430604dc25563388c2d"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.4.0/agyn_v0.4.0_darwin_amd64.tar.gz"
      sha256 "a5b2da3ed74dedfbbcd414582022f989d761d60413f04a3b9c87b6f9c51e584c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.4.0/agyn_v0.4.0_linux_arm64.tar.gz"
      sha256 "81f49a34ec27a4db1ce23337ba0ce116e0f20e10e4f10e86e6c85c394da569dd"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.4.0/agyn_v0.4.0_linux_amd64.tar.gz"
      sha256 "2421ee8650fcd95fb15aa411179df99784f18a753552fc7d5bc9c1a4f28e0d41"
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
