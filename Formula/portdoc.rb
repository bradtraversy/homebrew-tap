class Portdoc < Formula
  desc "Local dev server control panel"
  homepage "https://github.com/bradtraversy/portdoc"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.1/portdoc-aarch64-apple-darwin.tar.xz"
      sha256 "5f2ac583b26ba3ca2e39608423d597a4d7884a7d2c56afe2e93e21352eeb1ef0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.1/portdoc-x86_64-apple-darwin.tar.xz"
      sha256 "b73ccd29657c85913b6a0fe8abec401030b1eea1ffbcd46846cb5feefe0dee47"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.1/portdoc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bd2c51b21cae5198d5771037df92382e4536d8098341754bb5baf5576e308c4d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.1/portdoc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "06a6e2b4504c9d21659f314d3e0397540d48d9d03e8f75ed807ffc9d18fd1d13"
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
