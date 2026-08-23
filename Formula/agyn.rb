class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.19.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.19.0/agyn_v0.19.0_darwin_arm64.tar.gz"
      sha256 "e57c58ac3b190e4215719ebf70abec12b160a144838cc3c34cfdb4cf27070d35"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.19.0/agyn_v0.19.0_darwin_amd64.tar.gz"
      sha256 "cb6cbc4a65f486203ca38945f56effcb3f9c54dc6064444f8726169545f2ba7b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.19.0/agyn_v0.19.0_linux_arm64.tar.gz"
      sha256 "ab6e2b28d63f87d319c8ff7121cb0c9f986415b106e9db2a8ee73c9b7c130165"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.19.0/agyn_v0.19.0_linux_amd64.tar.gz"
      sha256 "2cc0809738342b6cb9d2d6d372c722f40e34c6553371c9df4d9cf412a358b59c"
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
