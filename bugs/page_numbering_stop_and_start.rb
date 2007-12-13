require File.dirname(__FILE__) + "/../lib/pdf/writer"

pdf = PDF::Writer.new
pdf.text "Using Version #{PDF::Writer::VERSION}"
#Page 1 of 3 with pdf version dispayed

sa = pdf.start_page_numbering(5, 60, 9, nil, nil)
pdf.start_new_page #page 2 of 3
pdf.start_new_page #page 3 of 3

pdf.stop_page_numbering(true, :current, sa)
pdf.start_new_page #blank page 

pdf.start_new_page #page 1 of 4
sc = pdf.start_page_numbering(5, 40, 9, nil, nil)
pdf.start_new_page #page 2 of 4
pdf.start_new_page #page 3 of 4
pdf.start_new_page #page 4 of 4
pdf.stop_page_numbering(true, :current, sc)
pdf.start_new_page #blank page
pdf.save_as "page_numbering_stop_and_start.pdf"