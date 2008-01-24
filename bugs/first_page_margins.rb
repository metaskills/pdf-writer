# this code shows that the margin settings are being ignored for the first page.
require File.dirname(__FILE__) + "/../lib/pdf/writer"

first_name = "<b>Joseph M.</b>"
last_name  = "Carmichael"
company    = "WSI Sound and Web Solutions"
title      = "Founder and CEO, Serial Entrepreneur extra extra"
tags       = %w(research social technology burningman gobots transformers)

pdf = PDF::Writer.new(:paper => [0,0,288,432]) # A6 
pdf.margins_pt(5, 5, 0, 5)
pdf.select_font "Helvetica" 

(0..5).each do |page|
  pdf.fill_color  Color::RGB::White  
  pdf.text first_name, :font_size => 42, :justification => :center
  pdf.text last_name, :font_size => 38, :justification => :center
  pdf.move_pointer(12)
  pdf.fill_color  Color::RGB::LightGrey
  pdf.text company, :font_size => 18, :justification => :center
  pdf.text title, :font_size => 18, :justification => :center
  pdf.fill_color  Color::RGB::Black
  pdf.move_pointer(22)
  pdf.text tags.collect{|t| " #{t}   <C:bullet />"}.join(' '), :font_size => 14, :justification => :center
  pdf.start_new_page
end

File.open("hello.pdf", "wb") { |f| f.write pdf.render }