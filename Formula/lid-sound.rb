class LidSound < Formula
  desc "Play sounds on MacBook lid events"
  homepage "https://github.com/charromax/lid-sound"
  url "https://github.com/charromax/lid-sound/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "999af280150ec17e0ebc1147911e7c7c62b104a758717a7f17e69e5fc17c5d14"
  license "MIT"
  revision 1

  depends_on :macos
  depends_on "swift" => :build

  def install
    ENV["SWIFTPM_DISABLE_SANDBOX"] = "1"
    ENV["HOME"] = buildpath
    ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version.to_s

    system "swift", "build", "-c", "release", "--disable-sandbox"

    bin.install ".build/release/lid-sound"
    bin.install Dir[".build/release/*.bundle"]
    (share/"lid-sound/sounds").install Dir["Sources/lid-sound/sounds/*.mp3"]
    (share/"lid-sound").install "Sources/LidSoundCore/Resources/lid-motion-loop.mp3"
  end

  test do
    system "#{bin}/lid-sound", "status"
  end
end
