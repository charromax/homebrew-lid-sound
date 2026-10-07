class LidSound < Formula
  desc "Play sounds on MacBook lid events"
  homepage "https://github.com/charromax/lid-sound"
  url "https://github.com/charromax/lid-sound/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "619923fb359a723e5ed8a0cf5beb8d15e47fdf28711d98da505733eefc2c2192"
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
    (share/"lid-sound").install "Sources/LidSoundCore/Resources/lid-motion-loop.mp3"
  end

  test do
    system "#{bin}/lid-sound", "status"
  end
end
