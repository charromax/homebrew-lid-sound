class LidSound < Formula
  desc "Play sounds on MacBook lid events"
  homepage "https://github.com/charromax/lid-sound"
  url "https://github.com/charromax/lid-sound/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "a9c528307d64d03df90ef335d74b7b17a025d59184db926ad53f144d2e069f25"
  license "MIT"

  depends_on :macos
  depends_on "swift" => :build

  def install
    ENV["SWIFTPM_DISABLE_SANDBOX"] = "1"
    ENV["HOME"] = buildpath
    ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version.to_s

    system "swift", "build", "-c", "release", "--disable-sandbox"

    bin.install ".build/release/lid-sound"
    (share/"lid-sound/sounds").install Dir["Sources/lid-sound/sounds/*.mp3"]
  end

  test do
    system "#{bin}/lid-sound", "status"
  end
end
