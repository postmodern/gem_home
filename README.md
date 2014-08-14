# gem_home

A tool for manipulating `$GEM_HOME` and `$GEM_PATH`.

## Features

* Supports pushing and popping directories from `$GEM_PATH`.
* Adds gem `bin/` directories to `$PATH` as well.
* Supports setting `$GEM_HOME` and reverting it to the last dir in `$GEM_PATH`.
* Supports using `vendor/gems/` directories.

## Synopsis

Change the `$GEM_HOME`:

    $ gem_home /path/to/project

Revert the `$GEM_HOME`:

    $ gem_home -

Use the `vendor/gems/` directory:

    $ gem_home --vendor

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
source /usr/local/share/gem_home.sh
```

### System Wide

If you wish to enable gem_home system-wide, add the following to
`/etc/profile.d/gem_home.sh`:

``` bash
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/local/share/gem_home.sh
  ...
fi
```

This will prevent `gem_home` from accidentally being loaded by `/bin/sh`, which
is not always the same as `/bin/bash`.

## Uninstall

After removing the `gem_home` configuration:

    $ sudo make uninstall

[1]: http://postmodern.github.com/contact.html#pgp
