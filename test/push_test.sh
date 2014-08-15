. ./test/helper.sh
. ./share/gem_home/gem_home.sh

function test_gem_home_push()
{
	local dir="$HOME/project1"
	local expected_gem_dir="$dir/.gem/$test_ruby_engine/$test_ruby_version"
	local original_path="$PATH"
	local original_gem_path="$GEM_PATH"

	gem_home_push "$dir"

	assertEquals "did not set \$GEM_HOME correctly" "$expected_gem_dir" \
		                                        "$GEM_HOME"

	assertEquals "did not prepend to \$GEM_PATH" "$expected_gem_dir:$original_gem_path" \
		                                     "$GEM_PATH"

	assertEquals "did not append bin/ to \$PATH" "$original_path:$expected_gem_dir/bin" \
	                                             "$PATH"
}

function test_gem_home_push_twice()
{
	local original_path="$PATH"
	local original_gem_path="$GEM_PATH"

	local dir1="$HOME/project1"
	local expected_gem_dir1="$dir1/.gem/$test_ruby_engine/$test_ruby_version"
	gem_home_push "$dir1"

	local dir2="$HOME/project2"
	local expected_gem_dir2="$dir2/.gem/$test_ruby_engine/$test_ruby_version"
	gem_home_push "$dir2"

	assertEquals "did not set \$GEM_HOME to the second gem dir" \
		     "$expected_gem_dir2" \
		     "$GEM_HOME"

	assertEquals "did not prepend both gem dirs to \$GEM_PATH" \
		     "$expected_gem_dir2:$expected_gem_dir1:$original_gem_path" \
		     "$GEM_PATH"

	assertEquals "did not append both gem bin/ dirs to \$PATH" \
		     "$original_path:$expected_gem_dir1/bin:$expected_gem_dir2/bin" \
		     "$PATH"

	gem_home_pop
}

function tearDown()
{
	gem_home_pop
}

SHUNIT_PARENT=$0 . $SHUNIT2
