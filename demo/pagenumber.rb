#--
# PDF::Writer for Ruby.
#   http://rubyforge.org/projects/ruby-pdf/
#   Copyright 2003 - 2005 Austin Ziegler.
#
#   Licensed under a MIT-style licence. See LICENCE in the main distribution
#   for full licensing information.
#
# $Id$
#++
begin
  require 'pdf/writer'
rescue LoadError => le
  if le.message =~ %r{pdf/writer$}
    $LOAD_PATH.unshift("../lib")
    require 'pdf/writer'
  else
    raise
  end
end

def grey_page(pdf)
  @page_num ||= 0
  @page_num += 1
  pdf.save_state
  pdf.fill_color Color::RGB::Grey90
  x = pdf.margin_x_middle - (pdf.text_width(@page_num, 48) / 2.0)
  y = pdf.margin_y_middle - (pdf.font_height(48) / 2.0)
  pdf.add_text(x, y, @page_num, 48)
  pdf.restore_state
end

def make_page(pdf)
  pdf.start_new_page
  grey_page(pdf)
end

pdf = PDF::Writer.new(:paper => "A10")
pdf.margins_pt 0
pdf.select_font "Helvetica"

x = pdf.absolute_x_middle

grey_page(pdf)  # Page  1: 99 of 99
sa = pdf.start_page_numbering(x, 70, 9, :center, nil, 99)
pdf.stop_page_numbering(true, :current, sa)
make_page(pdf)  # Page  2: 1 of 2
sa = pdf.start_page_numbering(x, 60, 9, nil, nil, 1)
make_page(pdf)  # Page  3: 2 of 2
pdf.stop_page_numbering(true, :current, sa)
make_page(pdf)  # Page  4: blank
sb = pdf.start_page_numbering(x, 50, 9, :center, nil, 10)
make_page(pdf)  # Page  5: 10 of 12
make_page(pdf)  # Page  6: 11 of 12
pdf.stop_page_numbering(true, :next, sb)
make_page(pdf)  # Page  7: 12 of 12
sc = pdf.start_page_numbering(x, 40, 9, nil, nil, 1)
make_page(pdf)  # Page  8: 1 of 3
make_page(pdf)  # Page  9: 2 of 3
make_page(pdf)  # Page 10: 3 of 3
pdf.stop_page_numbering(true, :current, sc)
make_page(pdf)  # Page 11: blank
sd = pdf.start_page_numbering(x, 30, 9, nil, nil, 1)
make_page(pdf)  # Page 12: 1 of 6
make_page(pdf)  # Page 13: 2 of 6
se = pdf.start_page_numbering(x, 20, 9, nil, nil, 5)
sf = pdf.start_page_numbering(x, 10, 9, :right, nil, 1)
make_page(pdf)  # Page 14: 3 of 6, 5 of 10, 1 of 8
make_page(pdf)  # Page 15: 4 of 6, 6 of 10, 2 of 8
make_page(pdf)  # Page 16: 5 of 6, 7 of 10, 3 of 8
pdf.stop_page_numbering(true, :next, sd)
make_page(pdf)  # Page 17: 6 of 6, 8 of 10, 4 of 8
make_page(pdf)  # Page 18: 9 of 10, 5 of 8
pdf.stop_page_numbering(true, :next, se)
pdf.stop_page_numbering(false, :current, sf)
make_page(pdf)  # Page 19: 10 of 10
make_page(pdf)  # Page 20: blank

pdf.save_as("pagenumber.pdf")
