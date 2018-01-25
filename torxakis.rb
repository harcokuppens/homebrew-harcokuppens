
class Torxakis < Formula
  desc "Tool for Model Based Testing"
  homepage "https://github.com/TorXakis/TorXakis"
  url "https://github.com/TorXakis/TorXakis/archive/v0.5.0.tar.gz"
  sha256 "03b370d2145206769e6cd12935404c5235a2afa6a779aef0aa3d0030057c6375"
  head "https://github.com/TorXakis/TorXakis.git"

  depends_on "haskell-stack" => :build
  depends_on "z3" => :recommended
  depends_on "cvc4" => :optional

  def install
    system "stack", "--stack-yaml=stack_linux.yaml", "setup"
    system "stack", "--stack-yaml=stack_linux.yaml", "build"
  end

  test do
    ohai "running unit tests"
    system "stack", "--stack-yaml=stack_linux.yaml", "test"
    ohai "running integration tests"
    system "stack", "--stack-yaml=test/sqatt/stack.yaml", "test"
  end
end
