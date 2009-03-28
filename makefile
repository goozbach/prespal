all: include.html push

push:
	bzr push

include.html: */indexblurb.txt */indexname.txt
	./.genout.sh > include.html 
	bzr ci include.html --unchanged -m "updated include.html via makefile"

