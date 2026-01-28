class LidSound < Formula
  desc "Play sounds on MacBook lid events"
  homepage "https://github.com/charromax/lid-sound"
  url "https://github.com/charromax/lid-sound/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "fc192b895ef25b535a0db6dbaa72f3beeb89756384159718ea2f5c25e2d6cc7f"
  license "MIT"

  depends_on :macos
  depends_on "swift" => :build

 def install
  ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version.to_s

  system "swift", "build", "-c", "release", "--disable-sandbox"
  bin.install ".build/release/lid-sound"
end

  test do
    system "#{bin}/lid-sound", "status"
  end
end
