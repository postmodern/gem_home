# gem_home

A tool for changing your `$GEM_HOME`.

## Features

* Supports pushing and popping directories from `$GEM_PATH`.
* Adds gem `bin/` directories to `$PATH` as well.
* Supports setting `$GEM_HOME` and reverting it to the last dir in `$GEM_PATH`.

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

    wget -O gem_home-0.0.1.tar.gz https://github.com/postmodern/gem_home/archive/v0.0.1.tar.gz
    tar -xzvf gem_home-0.0.1.tar.gz
    cd gem_home-0.0.1/
    sudo make install

### PGP

All releases are [PGP] signed for security. Instructions on how to import my
PGP key can be found on my [blog][1]. To verify that a release was not tampered 
with:

    wget https://raw.github.com/postmodern/gem_home/master/pkg/gem_home-0.0.1.tar.gz.asc
    gpg --verify gem_home-0.0.1.tar.gz.asc gem_home-0.0.1.tar.gz

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

## Uninstall

After removing the `gem_home` configuration:

    $ sudo make uninstall

[PGP]: http://en.wikipedia.org/wiki/Pretty_Good_Privacy

[1]: http://postmodern.github.com/contact.html#pgp
