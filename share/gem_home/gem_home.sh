function gem_home_push()
{
	mkdir -p "$1" && pushd "$1" >/dev/null || return 1
	local gem_dir="$PWD"

	GEM_HOME="$gem_dir"
	GEM_PATH="$gem_dir${GEM_PATH:+:}$GEM_PATH"
	PATH="$PATH${PATH:+:}$gem_dir/bin"

	popd >/dev/null
}

function gem_home_pop()
{
	local gem_dir="${GEM_PATH%%:*}"

	PATH=":$PATH:"
	GEM_PATH=":$GEM_PATH:"

	PATH="${PATH//:$gem_dir\/bin:/:}"
	GEM_PATH="${GEM_PATH//:$gem_dir:/:}"

	PATH="${PATH#:}"; PATH="${PATH%:}"
	GEM_PATH="${GEM_PATH#:}"; GEM_PATH="${GEM_PATH%:}"

	GEM_HOME="${GEM_PATH%%:*}"
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
			[[ -z "$GEM_PATH" ]] && return

			local gem_path="$GEM_PATH:"
			local gem_dir

			until [[ -z "$gem_path" ]]; do
				gem_dir="${gem_path%%:*}"

				if [[ "$gem_dir" == "$GEM_HOME" ]]; then
					echo " * $gem_dir"
				else
					echo "   $gem_dir"
				fi

				gem_path="${gem_path#*:}"
			done
			;;
		-)	gem_home_pop ;;
		--vendor)
			eval "$(ruby - <<EOF
puts "ruby_engine=#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'};"
puts "ruby_version=#{RbConfig::CONFIG['ruby_version']};"
EOF
)"
			gem_home_push "$PWD/vendor/gems/$ruby_engine/$ruby_version"
			;;
		*)
			eval "$(ruby - <<EOF
puts "ruby_engine=#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'};"
puts "ruby_version=#{RUBY_VERSION};"
EOF
)"
			gem_home_push "$1/.gem/$ruby_engine/$ruby_version"
			;;
	esac
}
