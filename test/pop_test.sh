. ./test/helper.sh
. ./share/gem_home/gem_home.sh

function setUp()
{
	original_path="$PATH"
	original_gem_home="$GEM_HOME"
	original_gem_path="$GEM_PATH"
}

function test_gem_home_pop()
{
	gem_home_push "$HOME/project1"
	gem_home_pop

	assertEquals "did not remove bin/ from \$PATH" "$original_path" \
		                                       "$PATH"

	assertEquals "did not remove gem dir from \$GEM_PATH" "$original_gem_path" \
		                                              "$GEM_PATH"

	assertEquals "did not reset \$GEM_HOME" "$original_gem_home" \
		                                "$GEM_HOME"
}

function test_gem_home_pop_twice()
{
	gem_home_push "$HOME/project1"
	gem_home_push "$HOME/project2"
	gem_home_pop
	gem_home_pop

	assertEquals "did not remove bin/ from \$PATH" "$original_path" \
		                                       "$PATH"

	assertEquals "did not remove gem dir from \$GEM_PATH" "$original_gem_path" \
		                                              "$GEM_PATH"

	assertEquals "did not reset \$GEM_HOME" "$original_gem_home" \
		                                "$GEM_HOME"
}

SHUNIT_PARENT=$0 . $SHUNIT2
