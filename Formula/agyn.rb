class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.2.20"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.20/agyn_v0.2.20_darwin_arm64.tar.gz"
      sha256 "597628801def1431eb33a866fbdb9772cc5dd467df8f2bfb05eee5f3fba6cfe9"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.20/agyn_v0.2.20_darwin_amd64.tar.gz"
      sha256 "92e15e37979befa69d24473ae0f14390a92e2f0b064d023abd24669788378388"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.20/agyn_v0.2.20_linux_arm64.tar.gz"
      sha256 "96abfdf3a60e8a885435784f603d6d709c40d9b30a2f1c593dce37456dccc85f"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.2.20/agyn_v0.2.20_linux_amd64.tar.gz"
      sha256 "c4c38883942d733f9d7b73c042e69cbc41a9715b1758e8490eb7d1a4dd563a3c"
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
