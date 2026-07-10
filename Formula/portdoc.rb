class Portdoc < Formula
  desc "Local dev server control panel"
  homepage "https://github.com/bradtraversy/portdoc"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.0/portdoc-aarch64-apple-darwin.tar.xz"
      sha256 "7077f88fff1cd0cbfd078a3626fe9d61ede46724bc99cb769a7850d6a57d6945"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.0/portdoc-x86_64-apple-darwin.tar.xz"
      sha256 "38a2fef452b4997b9da77cf88a77e9157ac11607d9ce1545843531f6000c0ce9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.0/portdoc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0a4e1a1f5ed8978752dfa5a8c0cb8de754a9ec6ee25965325a07280f03ad5000"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bradtraversy/portdoc/releases/download/v0.1.0/portdoc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba63a09b129d634b92bfe9af2036ce34c59ab426df4af2fb1589753ff535c1ee"
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
