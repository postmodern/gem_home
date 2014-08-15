. ./test/helper.sh
. ./share/gem_home/gem_home.sh

function test_gem_path_push()
{
	local dir="$HOME"
	local expected_dir="$dir/.gem/$test_ruby_engine/$test_ruby_version"
	local original_path="$PATH"
	local original_gem_path="$GEM_PATH"

	gem_home_push "$dir"

	assertEquals "did not set \$GEM_HOME correctly" "$expected_dir" \
		                                        "$GEM_HOME"

	assertEquals "did not prepend to \$GEM_PATH" "$expected_dir:$original_gem_path" \
		                                     "$GEM_PATH"

	assertEquals "did not prepend bin/ to \$PATH" "$expected_dir/bin:$original_path" \
	                                              "$PATH"
}

function tearDown()
{
	gem_home_pop
}

SHUNIT_PARENT=$0 . $SHUNIT2
