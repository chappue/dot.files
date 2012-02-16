all:
	echo "USAGE: \"make update\" or \"make install\""

.PHONY : update
update:
	svn update
	find . -type d -name ".svn" -prune -o -type f -and -regex "^\./\..*" -exec cp ~/{} {} \;
	svn status

.PHONY : install
install: $(FILES)
	find . -type d -name ".svn" -prune -o -type f -and -regex "^\./\..*" -exec cp {} ~/{} \;
