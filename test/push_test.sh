. ./test/helper.sh
. ./share/gem_home/gem_home.sh

function test_gem_home_push()
{
	local dir="$HOME/project1"
	local expected_gem_dir="$dir/.gem/$test_ruby_engine/$test_ruby_version"

	gem_home_push "$dir"

	assertEquals "did not set \$GEM_HOME correctly" "$expected_gem_dir" \
		                                        "$GEM_HOME"

	assertEquals "did not prepend to \$GEM_PATH" "$expected_gem_dir" \
		                                     "$GEM_PATH"

	assertEquals "did not append the new gem bin/ dir to \$PATH" \
		     "$original_path:$expected_gem_dir/bin" \
	             "$PATH"

	gem_home_pop
}

function test_gem_home_push_relative_path()
{
	local dir="foo/../project1"
	local expected_dir="$HOME/project1"
	local expected_gem_dir="$expected_dir/.gem/$test_ruby_engine/$test_ruby_version"

	gem_home_push "$dir"

	assertEquals "did not expand the relative gem dir" \
		     "$expected_gem_dir" \
		     "$GEM_HOME"

	gem_home_pop
}

function test_gem_home_push_with_GEM_HOME()
{
	local current_gem_home="$HOME/.gem/ruby/2.1.2"
	local current_gem_path="$HOME/.gem/ruby/2.1.2:/opt/rubies/ruby-2.1.2/lib/ruby/gems/2.1.0"
	local current_path="$PATH:$current_gem_home/bin"

	GEM_HOME="$current_gem_home"
	GEM_PATH="$current_gem_path"
	PATH="$current_path"

	local dir="$HOME/project1"
	local expected_gem_dir="$dir/.gem/$test_ruby_engine/$test_ruby_version"

	gem_home_push "$dir"

	assertEquals "did not inject the new bin/ before \$GEM_HOME/bin" \
		     "$original_path:$expected_gem_dir/bin:$current_gem_home/bin" \
	             "$PATH"

	gem_home_pop
}

function test_gem_home_push_twice()
{
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
		     "$expected_gem_dir2:$expected_gem_dir1" \
		     "$GEM_PATH"

	assertEquals "did not inject the new gem bin/ into \$PATH" \
		     "$original_path:$expected_gem_dir2/bin:$expected_gem_dir1/bin" \
		     "$PATH"

	gem_home_pop
	gem_home_pop
}

SHUNIT_PARENT=$0 . $SHUNIT2
