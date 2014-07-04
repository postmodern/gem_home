function gem_path()
{
	local version="0.0.1"

	case "$1" in
		-p|--push)
			local ruby_engine ruby_version

			eval "$("$RUBY_ROOT/bin/ruby" - <<EOF
puts "ruby_engine=#{defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'};"
puts "ruby_version=#{RUBY_VERSION};"
EOF
)"

			GEM_HOME="$2/.gem/$ruby_engine/$ruby_version"
			GEM_PATH="$GEM_HOME:$GEM_PATH"
			PATH="$GEM_HOME/bin:$PATH"
			;;
		-P|--pop)
			PATH=":$PATH:"
			GEM_PATH=":$GEM_PATH:"

			if [[ -n "$GEM_HOME" ]]; then
				PATH="${PATH//:$GEM_HOME\/bin:/:}"
				GEM_PATH="${GEM_PATH//:$GEM_HOME:/:}"
			fi

			PATH="${PATH#:}"; PATH="${PATH%:}"
			GEM_PATH="${GEM_PATH#:}"; GEM_PATH="${GEM_PATH%:}"
			GEM_HOME="${GEM_PATH%%:*}"
			;;
		-h|--help)
			cat <<USAGE
usage: gem_path [--push DIR | --pop]

Options:

	-p, --push DIR	Sets \$GEM_HOME and pushes DIR onto \$GEM_PATH
	-P, --pop	Pops the first directory off of \$GEM_PATH and
			resets \$GEM_HOME to the next directory.
	-V, --version		Prints the version
	-h, --help		Prints this message

Examples:

	$ gem_path --push /path/to/.gem

USAGE
			;;
		-V|--version)
			echo "gem_path: $version"
			;;
		"")
			local gem_path="$GEM_PATH:"

			until [[ -z "$gem_path" ]]; do
				echo "  ${gem_path%%:*}"
				gem_path="${gem_path#*:}"
			done
			;;
		*)
			printf "gem_path: unknown option: %s\n" "$1" >&2
			;;
	esac
}
