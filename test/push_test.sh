. ./test/helper.sh
. ./share/gem_home/gem_home.sh

function setUp()
{
	dir="$HOME"
	expected_dir="$dir/.gem/$test_ruby_engine/$test_ruby_version"
	original_path="$PATH"
	original_gem_path="$GEM_PATH"

	gem_home_push "$dir"
}

function test_gem_home_push_GEM_HOME()
{
	assertEquals "did not set \$GEM_HOME correctly" "$expected_dir" \
		                                        "$GEM_HOME"
}

function test_gem_home_push_GEM_PATH()
{
	assertEquals "did not prepend to \$GEM_PATH" "$expected_dir:$original_gem_path" \
		                                     "$GEM_PATH"
}

function test_gem_home_push_PATH()
{
	assertEquals "did not prepend bin/ to \$PATH" "$expected_dir/bin:$original_path" \
	                                              "$PATH"
}

function tearDown()
{
	gem_home_pop
}

SHUNIT_PARENT=$0 . $SHUNIT2
