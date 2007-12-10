require "test/helper"

describe "ImageInfo" do      
  
  String.class_eval do
    include PDF::Writer::OffsetReader
  end
  
  it "should not raise an error when measure_BMP is called" do   
     assert_nothing_raised do
       info = PDF::Writer::Graphics::ImageInfo.new '0'*20
       info.send :measure_BMP 
     end
  end
  
end