all:
	echo "USAGE: \"make update\" or \"make install\""

.PHONY : update
update:
	git pull origin master
	find . -type d \( -name ".git" -o -name "local-lisp" -o -name "var" -o -name "server" \) -prune -o -type d -and -regex "^\./\..*" -exec cp ~/{} {} \;
	git status

.PHONY : install
install: $(FILES)
	find . -type d -name ".git" -prune -o -type f -and -regex "^\./\..*" -exec cp {} ~/{} \;
