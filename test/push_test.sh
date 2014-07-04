. ./test/helper.sh

function test_gem_path_push()
{
	local dir="$HOME"
	local expected_dir="$dir/.gem/$test_ruby_engine/$test_ruby_version"
	local original_path="$PATH"
	local original_gem_path="$GEM_PATH"

	gem_path --push "$dir"

	assertEquals "did not set \$GEM_HOME correctly" "$GEM_HOME" \
		                                        "$expected_dir"

	assertEquals "did not prepend to \$GEM_PATH" "$GEM_PATH" \
		                                     "$expected_dir:$original_gem_path"

	assertEquals "did not prepend bin/ to \$PATH" "$PATH" \
		                                      "$expected_dir/bin:$original_path"
}

function tearDown()
{
	gem_path --pop
}

SHUNIT_PARENT=$0 . $SHUNIT2
