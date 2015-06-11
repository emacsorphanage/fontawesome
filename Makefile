.PHONY: data

data:
	ruby author/getfontinfo.rb > fontawesome-data.el
