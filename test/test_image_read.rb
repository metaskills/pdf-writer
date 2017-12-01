#encoding: UTF-8
$LOAD_PATH.unshift(File.dirname(__FILE__) + "/../lib")     
require "pdf/writer"

MAIN_TEXT_WIDTH        = 330
MAIN_TEXT_LINE_SPACING = 16
PADDING_BOTTOM         = 20

def write_text(pdf, text, options = {})
  y       = options[:y] if options[:y]
  left    = options[:left] if options[:left]
  width   = options[:width] if options[:width]  
  size    = options[:font_size] || 0
  height  = options[:leading]

  # Filled with the text that would flow onto the next page
  next_page_text = nil

  text.each_line do |line|
    start = true
    loop do 
      break if (line.nil? or line.empty?) and not start

      start = false

      y -= height

      if y < (pdf.absolute_bottom_margin + PADDING_BOTTOM)
        if options[:no_newpage]
          # Collect remaining text so it can be returned
          next_page_text = "" if next_page_text.nil?
          next_page_text += line
          line = nil
        else
          pdf.start_new_page
          y  = options[:new_page_y] || multi_page_top_y(pdf)
        end
      end

      if next_page_text.nil?
        line = pdf.add_text_wrap(left, y, width, line, size)
      end
    end
  end

  if options[:no_newpage]
    {:leftover_text => next_page_text, :next_line_y => y}
  else
    y
  end
end


pdf = PDF::Writer.new    
top_logo_file = '/Users/mwlang/projects/clients/taftlaw/taft_site/website/public/images/hr_taft_logo.jpg'
pdf.image(top_logo_file, {:width => 85, :justification => :right, :pad => 0 })

body = "\r\n\t\r\n\t\t\r\n\t\t\t\r\n\t\t\t\r\n\t\t\t\r\n\t\t\r\n\t\t\r\n\t\t\t\r\n\t\t\t\r\n\t\t\t\r\n\t\t\r\n\t\t\r\n\t\t\t\r\n\t\t\t\r\n\t\t\t\r\n\t\t\r\n\t\r\n\r\n\r\nCHARLES R. \"ROCKY\" SAXBE is Partner-in-Charge of the Columbus office. He maintains an active litigation practice representing clients in all aspects of civil litigation. Over the course of his illustrious career, he has acted as principal litigation counsel in numerous complex litigation cases, including serving as principal outside Ohio special counsel for the State of Ohio in the national tobacco litigation. He has appeared in numerous jury trials and has appeared before the Ohio Supreme Court, Ohio Courts of Appeals, and the Sixth Circuit U.S. Court of Appeals. According to <em>Chambers USA</em>, who interviews clients for feedback, Rocky is held in high regard \"for his political acumen, especially in election law-related and complex civil litigation.\" Rocky has a long affiliation with the political scene in Ohio, having served four terms in the Ohio House of Representatives. He provides counsel to elected officials, political party organizations and candidates on election, campaign finance and public ethics law.\r\n\r\n<strong>Representative Experience</strong>\r\n\r\n\r\n\t<C:bullet/>Served as principal outside Ohio special counsel for the State of Ohio in the \"national tobacco litigation,\" contributing significantly to the record setting $10 billion settlement for the State of Ohio.\r\n\t<C:bullet/>Has been the principal litigation counsel in numerous complex litigations, including numerous jury trials and has appeared before Ohio Supreme Court, Ohio Courts of Appeals, and the Sixth Circuit U.S. Court of Appeals.\r\n\t<C:bullet/>Provided counsel to elected officials, political party organizations and candidates on election, campaign finance and public ethics law.\r\n\t<C:bullet/>Frequent mediator assigned by the Federal Court for the Southern District of Ohio, providing expert testimony in the areas of attorneys' fees and malpractice.\r\n\t<C:bullet/>Serves as legislative counsel for the Ohio Association of Municipal and County Judges.\r\n\r\n\r\n<strong>Achievements and Awards</strong>\r\n\r\n\r\n\t<C:bullet/>Recipient of the Ohio State Bar Association Distinguished Service Award\r\n\t<C:bullet/>AV Peer Review (Preeminent) Rated by Martindale-Hubbell\r\n\t<C:bullet/><em>Best Lawyers in America, </em>Commercial Litigation, Government Relations Law & Bet-the-Company Litigation\r\n\t<C:bullet/>Listed for inclusion in <em>Ohio Super Lawyers</em>, General Litigation (2004 - 2013)\r\n\t<C:bullet/><em>Chambers USA</em>, Litigation\r\n\r\n\r\n<strong>Professional Memberships and Community Service</strong>\r\n\r\n\r\n\t<C:bullet/>Columbus Bar Association\r\n\t<C:bullet/>Ohio State Bar Association\r\n\t<C:bullet/>American Bar Associations\r\n\t<C:bullet/>Champaign County Bar Association\r\n\t<C:bullet/>Greater Columbus Arts Council, Past Chairman\r\n\t<C:bullet/>Bexley Library Board, Past President\r\n\t<C:bullet/>Columbus College of Art and Design, Past Chairman\r\n\t<C:bullet/>Central State University, Past Trustee\r\n\t<C:bullet/>Mechanicsburg Lodge #113 F&AM, Past Master\r\n\t<C:bullet/>Ancient and Accepted Scottish Rite, 33°\r\n\t<C:bullet/>Vietnam Veterans of America\r\n\t<C:bullet/>American Legion\r\n\t<C:bullet/>Scioto Valley Rugby Football Club (SVRFC Hall of Fame)\r\n\r\n\r\n<strong>Other Professional Experience</strong>\r\n\r\n\r\n\t<C:bullet/>U.S. Marine Corps, infantry platoon commander with the First Marine Division in the Republic of Vietnam and was discharged with the rank of Captain\r\n\t<C:bullet/>Elected to the Ohio House of Representatives in 1974 where he served four terms\r\n\t<C:bullet/>Republican nominee for Ohio Attorney General in 1982\r\n\r\n"
write_text(pdf, 
  body, 
  {
    :no_newpage => true, 
    :y => pdf.absolute_top_margin - 140, 
    :left => pdf.absolute_left_margin, 
    :leading => MAIN_TEXT_LINE_SPACING, 
    :width => MAIN_TEXT_WIDTH
  }
)

pdf.render