[[ -z "$SHUNIT2"     ]] && SHUNIT2=/usr/share/shunit2/shunit2
[[ -n "$ZSH_VERSION" ]] && setopt shwordsplit

export PREFIX="$PWD/test"
export HOME="$PREFIX/home"
export PATH="$PWD/bin:$PATH"

eval "$("$RUBY_ROOT/bin/ruby" - <<EOF
puts "test_ruby_engine=#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'};"
puts "test_ruby_version=#{RUBY_VERSION};"
puts "test_ruby_api_version=#{RbConfig::CONFIG['ruby_version']};"
puts "test_ruby_patchlevel=#{RUBY_PATCHLEVEL};"
EOF
)"

setUp() { return; }
tearDown() { return; }
oneTimeTearDown() { return; }
