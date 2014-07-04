. ./test/helper.sh

function test_gem_path_push()
{
	local dir="$HOME"
	local expected_dir="$dir/.gem/$test_ruby_engine/$test_ruby_version"

	gem_path --push "$dir"

	assertEquals "did not set \$GEM_HOME correctly" "$GEM_HOME" \
		                                        "$expected_dir"
}

SHUNIT_PARENT=$0 . $SHUNIT2
