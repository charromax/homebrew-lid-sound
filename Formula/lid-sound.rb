class LidSound < Formula
  desc "Play sounds on MacBook lid events"
  homepage "https://github.com/charromax/lid-sound"
  url "https://github.com/charromax/lid-sound/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "fc192b895ef25b535a0db6dbaa72f3beeb89756384159718ea2f5c25e2d6cc7f"
  license "MIT"

  depends_on :macos
  depends_on "swift" => :build

  def install
    # Avoid SwiftPM trying to use sandbox-exec (can fail under Homebrew's build sandbox)
    ENV["SWIFTPM_DISABLE_SANDBOX"] = "1"

    # Ensure SwiftPM has a writable HOME for its internal state/caches
    ENV["HOME"] = buildpath

    # Align deployment target with the running macOS to avoid linker target mismatches
    ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version.to_s

    system "swift", "build", "-c", "release", "--disable-sandbox"

    # Install executable
    bin.install ".build/release/lid-sound"

    # SwiftPM resources for executables are emitted as a sibling bundle named:
    #   <target>_<target>.bundle
    # Bundle.module expects it next to the executable at runtime.
    bundle = ".build/release/lid-sound_lid-sound.bundle"
    bin.install bundle if File.exist?(bundle)
  end

  test do
    system "#{bin}/lid-sound", "status"
  end
end
