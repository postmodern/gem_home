[[ -z "$SHUNIT2"     ]] && SHUNIT2=/usr/share/shunit2/shunit2
[[ -n "$ZSH_VERSION" ]] && setopt shwordsplit

export PREFIX="$PWD/test"
export HOME="$PREFIX/home"
export PATH="$PWD/bin:$PATH"

if [[ -z "${GEM_PATH}" && -n "${GEM_HOME}" ]] || [[ -n "${GEM_PATH}" && -z "${GEM_HOME}" ]]; then
    printf \
        '\n\033[1;31m!!! WARN\033[0m\n\033[1;31m!!! \033[0m\033[1m%s\033[0m\n\033[1;31m!!! \033[0m\033[1m%s\033[0m\n\n' \
        'Prior to running tests, either unset the GEM_PATH and GEM_HOME variables OR set them both!' \
        'Ignoring this and using a combination of these variables set and unset will cause issues...'
fi

eval "$(ruby - <<EOF
puts "test_ruby_engine=#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'};"
puts "test_ruby_version=#{RUBY_VERSION};"
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
