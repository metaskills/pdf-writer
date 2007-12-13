require File.dirname(__FILE__) + "/../lib/pdf/writer"

pdf = PDF::Writer.new
pdf.text "Using Version #{PDF::Writer::VERSION}"
#Page 1 of 3 with pdf version dispayed

sa = pdf.start_page_numbering(5, 60, 9, nil, nil)
pdf.start_new_page #page 2 of 3
pdf.start_new_page #page 3 of 3
  
# Uncomment to fix behaviour, but this should not be needed!
# pdf.stop_page_numbering(true)

pdf.save_as "page_numbering_simple.pdf"