#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'
require 'erb'

url = 'http://fortawesome.github.io/Font-Awesome/cheatsheet/'
doc = Nokogiri::HTML.parse(open(url))

fonts = []
doc.css('div.row > div').each do |e|
  font_name_nodes = e.children.select do |t|
    t.text? && !t.text.strip.empty?
  end

  next unless font_name_nodes.length == 1

  font_name = font_name_nodes.first.text.strip
  abort "Error: Invalid font name '#{font_name}'" unless font_name =~ /\Afa-/

  muted = e.css('span.text-muted')
  entity = muted[0].text
  entity = muted[1].text if entity =~ /\(alias\)/
  if entity =~ /\A\[&#([^;]+);\]\z/
    code = "\\" + Regexp.last_match[1]
    fonts << { name: font_name.sub!(/\Afa-/, ""), code: code }
  end
end

template =<<EOS
;; This file is generated automatically. Don't change this file !!
(defvar fontawesome-alist
'(
<% fonts.each do |font| %>
("<%= font[:name] %>" . "<%= font[:code] %>")<% end %>
))

(provide 'fontawesome-data)
EOS

erb = ERB.new(template)
puts erb.result(binding)
