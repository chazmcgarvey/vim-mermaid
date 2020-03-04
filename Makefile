
VIM ?= vim

all:

run: test

test: test.mmd
	$(VIM) -u test.vimrc --cmd 'let &runtimepath=".,".&runtimepath' $^

.PHONY: all run test
