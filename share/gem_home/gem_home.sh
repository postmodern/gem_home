function gem_home_push()
{
	local gem_dir="$1"

	GEM_HOME="$gem_dir"
	GEM_PATH="$gem_dir${GEM_PATH:+:}$GEM_PATH"
	PATH="$PATH${PATH:+:}$gem_dir/bin"
}

function gem_home_pop()
{
	local gem_dir="${GEM_PATH%:*}"

	PATH=":$PATH:"
	GEM_PATH=":$GEM_PATH:"

	PATH="${PATH//:$gem_dir\/bin:/:}"
	GEM_PATH="${GEM_PATH//:$gem_dir:/:}"

	PATH="${PATH#:}"; PATH="${PATH%:}"
	GEM_PATH="${GEM_PATH#:}"; GEM_PATH="${GEM_PATH%:}"

	GEM_HOME="${GEM_PATH%:*}"
}

function gem_home()
{
	local ruby_engine ruby_version
	local version="0.0.1"

	case "$1" in
		-V|--version)	echo "gem_home: $version" ;;
		-h|--help)
			cat <<USAGE
usage: gem_home [OPTIONS] [DIR|-]

Options:
	--vendor	Sets ./vendor/gems as the \$GEM_HOME
	-V, --version	Prints the version
	-h, --help	Prints this message

Argumens:
	DIR	Sets DIR as the new \$GEM_HOME
	-	Reverts to the previous \$GEM_HOME

Examples:

	$ gem_home path/to/project
	$ gem_home -
	$ gem_home --vendor

USAGE
			;;
		"")
			local gem_path="$GEM_PATH:"

			until [[ -z "$gem_path" ]]; do
				echo "  ${gem_path%%:*}"
				gem_path="${gem_path#*:}"
			done
			;;
		-)	gem_home_pop ;;
		--vendor)
			eval "$("$RUBY_ROOT/bin/ruby" - <<EOF
puts "ruby_engine=#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'};"
puts "ruby_version=#{RbConfig::CONFIG['ruby_version']};"
EOF
)"
			gem_home_push "$PWD/vendor/gems/$ruby_engine/$ruby_version"
			;;
		*)
			eval "$("$RUBY_ROOT/bin/ruby" - <<EOF
puts "ruby_engine=#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'};"
puts "ruby_version=#{RUBY_VERSION};"
EOF
)"
			gem_home_push "$1/.gem/$ruby_engine/$ruby_version"
			;;
	esac
}
