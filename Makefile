SHELL := /usr/bin/env bash

EMACS ?= emacs
EASK ?= eask

TEST-FILES := $(shell ls test/fontawesome-*.el)

.PHONY: data clean checkdoc lint install compile unix-test

data:
	ruby author/getfontinfo.rb > fontawesome-data.el

ci: clean install compile

clean:
	@echo "Cleaning..."
	$(EASK) clean-all

install:
	@echo "Installing..."
	$(EASK) install

compile:
	@echo "Compiling..."
	$(EASK) compile

lint:
	@echo "Linting..."
	$(EASK) lint

unix-test:
	@echo "Testing..."
	$(EASK) exec ert-runner -L . $(LOAD-TEST-FILES) -t '!no-win' -t '!org'
