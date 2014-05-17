data: fontawesome-data.el

fontawesome-data.el:
	ruby author/getfontinfo.rb > $@
