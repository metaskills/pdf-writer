require "test/helper"

describe "Page Numbering" do
  
  before :each do 
    @pdf = PDF::Writer.new
  end
  
  it "should start with a current page = 1" do
    @pdf.current_page_number.should == 1
  end   
  
end