class LidSound < Formula
  desc "Play sounds on MacBook lid events"
  homepage "https://github.com/charromax/lid-sound"
  url "https://github.com/charromax/lid-sound/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "094a0c01261aeb76f4562cb67cd1b77eb45d5b96b5de4e6dadd14eac482dd5f2"
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
