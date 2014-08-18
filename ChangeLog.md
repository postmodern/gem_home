### 0.1.0 / 2014-08-18

* Initial release:
  * Updates `$GEM_HOME`, `$GEM_PATH` and `$PATH`.
    * Switches `$GEM_HOME` by pushing and popping gem directories to
      `$GEM_PATH`. This allows the stacking of multiple gem directories.
    * Prepends the new `$GEM_HOME/bin` to `$PATH` so it takes precedence.
  * Compartmentalizes gems into `.gem/$ruby_engine/$ruby_version`.

