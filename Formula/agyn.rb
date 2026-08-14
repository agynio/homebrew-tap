class Agyn < Formula
  desc "CLI for the Agyn platform"
  homepage "https://github.com/agynio/agyn-cli"
  version "0.17.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.17.1/agyn_v0.17.1_darwin_arm64.tar.gz"
      sha256 "74dc1400be17178a0a51a833b51d7c2626226804d9b12478cdbfae8952aea6ea"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.17.1/agyn_v0.17.1_darwin_amd64.tar.gz"
      sha256 "2b107d0d4d178954b60ad2133543a1b1a476cb51c2801b74eeb9762e51288468"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agynio/agyn-cli/releases/download/v0.17.1/agyn_v0.17.1_linux_arm64.tar.gz"
      sha256 "ab1cbca83a57524451bc99432c2191fd2146594a3a529d38a67ae081949ab209"
    else
      url "https://github.com/agynio/agyn-cli/releases/download/v0.17.1/agyn_v0.17.1_linux_amd64.tar.gz"
      sha256 "b7b4ac07071a932c0e9ef21e4db33024fa9c9955cc26c9b56ea22f37ca550f8c"
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
