# gem_home

[![Build Status](https://travis-ci.org/postmodern/gem_home.png)](https://travis-ci.org/postmodern/gem_home)

Changes your `$GEM_HOME`.

## Features

* Updates `$GEM_HOME`, `$GEM_PATH` and `$PATH`.
  * Switches `$GEM_HOME` by pushing and popping gem directories to `$GEM_PATH`.
    This allows the stacking of multiple gem directories.
  * Prepends the new `$GEM_HOME/bin` to `$PATH` so it takes precedence.
* Compartmentalizes gems into `.gem/$ruby_engine/$ruby_version`.
* Plays nicely with [RVM] and [chruby].
* Optional auto-switching.
* Supports [bash] and [zsh].
* Small (~90 LOC).
* Has tests.

## Synopsis

Change the `$GEM_HOME`:

    $ gem_home /path/to/project

Revert the `$GEM_HOME`:

    $ gem_home -

Using with bundler:

    $ cd padrino-app/
    $ gem_home .
    $ bundle install
    Fetching gem metadata from https://rubygems.org/.........
    Resolving dependencies...
    Using rake 10.3.2
    Using i18n 0.6.11
    Using json 1.8.1
    Using minitest 5.4.0
    Using thread_safe 0.3.4
    Installing tzinfo 1.2.2
    Using activesupport 4.1.4
    Using addressable 2.3.6
    Installing builder 3.2.2
    Using bundler 1.6.2
    Using data_objects 0.10.14
    Using dm-core 1.2.1
    Using dm-aggregates 1.2.0
    Using dm-do-adapter 1.2.0
    Using dm-migrations 1.2.0
    ...    
    $ padrino console # no `bundle exec` needed

* Notice how bundler re-used many of the gems from `~/.gem/...` but installed
  missing gems into `$PWD/.gem/...`.


## Install

    wget -O gem_home-0.1.0.tar.gz https://github.com/postmodern/gem_home/archive/v0.1.0.tar.gz
    tar -xzvf gem_home-0.1.0.tar.gz
    cd gem_home-0.1.0/
    sudo make install

### PGP

All releases are [PGP] signed for security. Instructions on how to import my
PGP key can be found on my [blog][1]. To verify that a release was not tampered 
with:

    wget https://raw.github.com/postmodern/gem_home/master/pkg/gem_home-0.1.0.tar.gz.asc
    gpg --verify gem_home-0.1.0.tar.gz.asc gem_home-0.1.0.tar.gz

### Homebrew

gem_home can also be installed with [homebrew]:

    brew install --HEAD https://raw.github.com/postmodern/gem_home/master/homebrew/gem_home.rb

## Configuration

Add the following to the `~/.bashrc` or `~/.zshrc` file:

``` bash
source /usr/local/share/gem_home/gem_home.sh
```

### System Wide

If you wish to enable gem_home system-wide, add the following to
`/etc/profile.d/gem_home.sh`:

``` bash
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/local/share/gem_home/gem_home.sh
  ...
fi
```

This will prevent `gem_home` from accidentally being loaded by `/bin/sh`, which
is not always the same as `/bin/bash`.

### Auto-switching

This feature's workflow is similar to [chruby's `auth.sh`](https://github.com/postmodern/chruby/blob/master/share/chruby/auto.sh):

If you want to auto-switch current `$GEM_HOME` when you cd between your different projects, simply load `auto.sh` in `~/.bashrc` or `~/.zshrc`:

``` bash
source /usr/local/share/gem_home/gem_home.sh
source /usr/local/share/gem_home/auto.sh
```

gem_home will check the current and parent directories for a `.ruby-gemhome` file, which contains a path to the custom $GEM_HOME.

## Uninstall

After removing the `gem_home` configuration:

    $ sudo make uninstall

## Alternatives

* [gs](https://github.com/inkel/gs#readme)
* [gst](https://github.com/tonchis/gst#readme)
* [ohmygems](http://blog.zenspider.com/blog/2012/09/ohmygems.html)
* [renv](https://github.com/fnichol/renv)

[RVM]: https://rvm.io/
[chruby]: https://github.com/postmodern/chruby#readme

[bash]: http://www.gnu.org/software/bash/
[zsh]: http://www.zsh.org/

[PGP]: http://en.wikipedia.org/wiki/Pretty_Good_Privacy
[homebrew]: http://brew.sh/

[1]: http://postmodern.github.com/contact.html#pgp
