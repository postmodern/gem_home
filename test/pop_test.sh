. ./test/helper.sh
. ./share/gem_home/gem_home.sh

function setUp()
{
	original_path="$PATH"
	original_gem_home="$GEM_HOME"
	original_gem_path="$GEM_PATH"

	gem_home_push "$HOME"
}

function test_pop()
{
	gem_home_pop

	assertEquals "did not remove bin/ from \$PATH" "$original_path" \
		                                       "$PATH"

	assertEquals "did not remove gem dir from \$GEM_PATH" "$original_gem_path" \
		                                              "$GEM_PATH"

	assertEquals "did not reset \$GEM_HOME" "$original_gem_home" \
		                                "$GEM_HOME"
}

SHUNIT_PARENT=$0 . $SHUNIT2
