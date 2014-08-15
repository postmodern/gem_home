[[ -z "$SHUNIT2"     ]] && SHUNIT2=/usr/share/shunit2/shunit2
[[ -n "$ZSH_VERSION" ]] && setopt shwordsplit

export PREFIX="$PWD/test"
export HOME="$PREFIX/home"
export PATH="$PWD/bin:$PATH"

#export GEM_HOME="$HOME/.gem/ruby/2.1.2"
#export GEM_PATH="$HOME/.gem/ruby/2.1.2:/opt/rubies/ruby-2.1.2/lib/ruby/gems/2.1.0"

eval "$(ruby - <<EOF
puts "test_ruby_engine=#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'};"
puts "test_ruby_version=#{RUBY_VERSION};"
puts "test_ruby_api_version=#{RbConfig::CONFIG['ruby_version']};"
puts "test_ruby_patchlevel=#{RUBY_PATCHLEVEL};"
EOF
)"

function setUp()
{
	original_path="$PATH"
	original_gem_home="$GEM_HOME"
	original_gem_path="$GEM_PATH"

	cd "$HOME"
}
function tearDown()
{
	GEM_HOME="$original_gem_home"
	GEM_PATH="$original_gem_path"
	PATH="$original_path"
}
function oneTimeTearDown() { return; }
