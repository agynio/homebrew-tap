class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.20.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.20.0/agyn_v0.20.0_darwin_arm64.tar.gz"
      sha256 "1f3966bb323c10acc2860b6a7012f53baf257c6b4f166a5645ff1691b5d525a9"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.20.0/agyn_v0.20.0_darwin_amd64.tar.gz"
      sha256 "696a6043f1808dfc9055c0e1d760852fb6d57b1b73af913367d07cceab21d0e9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.20.0/agyn_v0.20.0_linux_arm64.tar.gz"
      sha256 "e687bb85fe894aef9ec155826adc0db2c3bb20315f0e03010c60c801795e04af"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.20.0/agyn_v0.20.0_linux_amd64.tar.gz"
      sha256 "a8fa1d93c83f6dfa53d604929ab5637731fa9b00f5f900815ef88153ae4ee779"
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
