# mkcd function -- makes a directory, then cd into it
mkcd() {
	local dir="$*"
	mkdir -p "$dir" && cd "$dir"
}

# alias simple commands
alias bat=batcat
alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# git commands
alias gp="git pull"
alias pull="git pull"
alias gP="git push"
alias push="git push"
alias gcc="git checkout"
alias gcb="git checkout -b"

# gcm function -- checkout default branch
gcm() {
	local branch="$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')"

	git checkout "$branch"
}
