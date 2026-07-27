class Portdoc < Formula
  desc "Local dev server control panel"
  homepage "https://github.com/bradtraversy/portdoc"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.2/portdoc-aarch64-apple-darwin.tar.xz"
      sha256 "0a4493eddca34fe9ebbd010c53682a75dfaf7e01c52a4dabf79b9b8b0cf755c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.2/portdoc-x86_64-apple-darwin.tar.xz"
      sha256 "bd392be6934c7b2d4f205d912de663ffbbc33104e0c9421240aa5693b509c055"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.2/portdoc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2dc09e7b084cc33ca9bcc30aa44ced1309a1fcfd1f063c03db1ff4f6ddccf059"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.2/portdoc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "54564dda0520e7e489c93f292a58956865ec90e60526c8cfa9dff5980bf1bf9f"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "portdoc" if OS.mac? && Hardware::CPU.arm?
    bin.install "portdoc" if OS.mac? && Hardware::CPU.intel?
    bin.install "portdoc" if OS.linux? && Hardware::CPU.arm?
    bin.install "portdoc" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
