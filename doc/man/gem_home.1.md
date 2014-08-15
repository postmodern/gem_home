# gem_home 1 "Aug 2014" gem_home "User Manuals"

## SYNOPSIS

`gem_home` [OPTIONS] [DIR\|-]

## DESCRIPTION

Changes the `$GEM_HOME` by pushing directories on or off of `$GEM_PATH`.

## ARGUMENTS

*DIR*
    Sets DIR as the new `$GEM_HOME`.

*-*
    Reverts to the previous `$GEM_HOME`.

## OPTIONS

`-h`, `--help`
    Prints help.

`-v`, `--version`
    Prints the version.

## EXAMPLES

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

## ENVIRONMENT

*PATH*
    Updates the PATH environment variable to include Rubies and RubyGems
    `bin/` directories.

*GEM_HOME*
    Default repository location for gem installation.

*GEM_PATH*
    A colon-separated list of gem repository directories.
    
## AUTHOR

Postmodern [postmodern.mod3\@gmail.com](mailto:postmodern.mod3\@gmail.com).

## SEE ALSO

gem(1)
