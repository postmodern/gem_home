require 'formula'

class GemHome < Formula
  desc "Changes your $GEM_HOME"
  homepage 'https://github.com/postmodern/gem_home#readme'
  url 'https://github.com/postmodern/gem_home/archive/v0.1.0.tar.gz'
  sha256 '67e9e174de42de640f144f88cd16b2a315bdec55567467743f8fbb96cba14e4e'
  license "MIT"

  head 'https://github.com/postmodern/gem_home.git'

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end
end
