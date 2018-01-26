
class Torxakis < Formula
  desc "Tool for Model Based Testing"
  homepage "https://github.com/TorXakis/TorXakis"
  url "https://github.com/TorXakis/TorXakis/archive/v0.5.0.tar.gz"
  sha256 "03b370d2145206769e6cd12935404c5235a2afa6a779aef0aa3d0030057c6375"
  head "https://github.com/TorXakis/TorXakis.git"

  bottle do
    cellar :any_skip_relocation
    root_url "https://raw.githubusercontent.com/harcokuppens/homebrew-homebrew/master/bottles/"
    sha256 "7c9ebc6abb1edb4bef5977cf85164cbf0aa3344ddcbf102e0aa1cc344645e337" => :high_sierra
  end

  depends_on "haskell-stack" => :build
  depends_on "z3" => :recommended
  depends_on "cvc4" => :optional

  def install
    ohai "running install"
    jobs = ENV.make_jobs
    ENV.deparallelize
    system "stack", "-j#{jobs}", "--stack-yaml=stack_linux.yaml", "setup"
    system "stack", "-j#{jobs}", "--stack-yaml=stack_linux.yaml", "--local-bin-path=#{bin}", "install"
  end

  test do
    ohai "running basic test"
    output_torxakis = pipe_output('printf "eval 33+7777777777777\nq" |torxakis  2>&1')
    assert_match(/7777777777810/, output_torxakis, 'torxakis failed in doing "eval 33+7777777777777"')
    ohai "test succesfull"
  end
end
