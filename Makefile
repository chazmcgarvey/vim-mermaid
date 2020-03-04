
VIM ?= vim

all:

run: test

test: test.mmd
	$(VIM) --cmd 'let &runtimepath=".,".&runtimepath' $^

.PHONY: all run test
