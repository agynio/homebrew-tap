class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.2/agyn_v0.3.2_darwin_arm64.tar.gz"
      sha256 "32c2bfb0cb6c049fba601bacda7b13d33b8a923cbb1245c709cd2004ada9bd0d"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.2/agyn_v0.3.2_darwin_amd64.tar.gz"
      sha256 "a0e9b83c68c294f0e06bc5557208729634f0334afdeae6df841a4aacd7541462"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.2/agyn_v0.3.2_linux_arm64.tar.gz"
      sha256 "4a678495f9bb20a052a2e13f8b96e672318838b56593d891a3b4f22b494907fc"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.3.2/agyn_v0.3.2_linux_amd64.tar.gz"
      sha256 "c7693bfaee809618d7fb0e34cec97134caee3ee8af49f7b42b3dad382b8096c7"
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
