require "test/helper"

describe "Page Numbering" do
  
  before :each do 
    @pdf = PDF::Writer.new
  end
  
  it "should start with a current page = 1" do
    @pdf.current_page_number.should == 1
  end   
  
  it "should not raise an error when starting value isn't set" do
     assert_nothing_raised do
       @pdf.start_page_numbering(0,0,12, nil, nil)                   
     end
  end 
  
  it "should raise an error when starting is set (disabled due to bugginess" do
    assert_raises(RuntimeError) do
      @pdf.start_page_numbering(0,0,12,nil,nil,1)
    end
  end
  
end