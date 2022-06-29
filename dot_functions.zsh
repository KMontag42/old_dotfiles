#########################################
# Make a directory and cd into it       #
#########################################
function mkd()  {
	mkdir -p -- "$@" && cd -- "$@"
}

#########################################
# cd to the root of git directory       #
#########################################
function root() {
	while ! [ -d .git ]; do
		cd ..
	done
}

#########################################
# Move target $1 to $1.bak              #
#                                       #
# https://github.com/shazow/dotfiles/   #
#########################################
function bak() {
    declare target=$1;
    if [[ "${target:0-1}" = "/" ]]; then
        target=${target%%/}; # Strip trailing / of directories
    fi
    mv -v $target{,.bak}
}

#########################################
# Move target $1.bak to $1              #
#                                       #
# https://github.com/shazow/dotfiles/   #
#########################################
function unbak() {
    declare target=$1;
    if [[ "${target:0-1}" = "/" ]]; then
        # Strip trailing / of directories
        target="${target%%/}"
    fi

    if [[ "${target:0-4}" = ".bak" ]]; then
        mv -v "$target" "${target%%.bak}"
    else
        echo "No .bak extension, ignoring: $target"
    fi
}

function _unbak() {
    compadd "${(@)$(ls *.bak)}"
}

compdef _unbak unbak

function dy { dig +noall +answer +additional "$1" @dns.toys; }

# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}

# makes a new conda env for the current directory
condanew() {
    conda create -n $(basename $PWD) python=3.9 -y
    source activate $(basename $PWD)
    echo "layout anaconda $(basename $PWD)" > .envrc
}

