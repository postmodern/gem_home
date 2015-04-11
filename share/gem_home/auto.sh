unset GEM_HOME_AUTO

if [ -z "$GEM_HOME_FILENAME" ]; then
  export GEM_HOME_FILENAME=".ruby-gemhome"
fi

function gem_home_auto() {
	local dir="$PWD/" gem_dir

	until [[ -z "$dir" ]]; do
		dir="${dir%/*}"

		if { read -e gem_dir <"$dir/$GEM_HOME_FILENAME"; } 2>/dev/null || [[ -n "$gem_dir" ]]; then
			if [[ "$gem_dir" == "$GEM_HOME_AUTO" ]]; then return
			else
				GEM_HOME_AUTO="$gem_dir"
				gem_home "$gem_dir"
				return $?
			fi
		fi
	done

	if [[ -n "$GEM_HOME_AUTO" ]]; then
		gem_home -
		unset GEM_HOME_AUTO
	fi
}

if [[ -n "$ZSH_VERSION" ]]; then
	if [[ ! "$preexec_functions" == *chruby_auto* ]]; then
		preexec_functions+=("gem_home_auto")
	fi
elif [[ -n "$BASH_VERSION" ]]; then
	trap '[[ "$BASH_COMMAND" != "$PROMPT_COMMAND" ]] && gem_home_auto' DEBUG
fi