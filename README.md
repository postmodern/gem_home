# gem_path

**WARNING: THIS IS AN EXPERIMENT**

A tool for manipulating `$GEM_PATH`.

## Features

* Supports pushing / popping directories from `$GEM_PATH`.
* Updates `$PATH` accordingly.

## Synopsis

Pushes a directory onto the front of `$GEM_PATH` and set `$GEM_HOME`:

    $ gem_path --push /path/to/.gem

Pops a directory off of `$GEM_PATH` and resets `$GEM_HOME` to the next
directory:

    $ gem_path --pop

## Install

    wget -O gem_path-0.0.1.tar.gz https://github.com/postmodern/gem_path/archive/v0.0.1.tar.gz
    tar -xzvf gem_path-0.0.1.tar.gz
    cd gem_path-0.0.1/
    sudo make install

### PGP

All releases are [PGP] signed for security. Instructions on how to import my
PGP key can be found on my [blog][1]. To verify that a release was not tampered 
with:

    wget https://raw.github.com/postmodern/gem_path/master/pkg/gem_path-0.0.1.tar.gz.asc
    gpg --verify gem_path-0.0.1.tar.gz.asc gem_path-0.0.1.tar.gz

## Configuration

Add the following to the `~/.bashrc` or `~/.zshrc` file:

``` bash
source /usr/local/share/gem_path.sh
```

### System Wide

If you wish to enable gem_path system-wide, add the following to
`/etc/profile.d/gem_path.sh`:

``` bash
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/local/share/gem_path.sh
  ...
fi
```

This will prevent gem_path from accidentally being loaded by `/bin/sh`, which
is not always the same as `/bin/bash`.

## Uninstall

After removing the chruby configuration:

    $ sudo make uninstall

[1]: http://postmodern.github.com/contact.html#pgp
