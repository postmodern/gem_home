require 'formula'

class GemHome < Formula
  homepage 'https://github.com/postmodern/gem_home#readme'
  url 'https://github.com/postmodern/gem_home/archive/v0.0.1.tar.gz'
  sha1 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

  head 'https://github.com/postmodern/gem_home.git'

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end
end
