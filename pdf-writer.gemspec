Gem::Specification.new do |s|
  s.name     = "pdf-writer"
  s.version  = "1.2.3"
  s.date     = "2009-05-19"
  s.summary  = "A pure Ruby PDF document creation library."
  s.email    = "ken@metaskills.net"
  s.homepage = "http://github.com/metaskills/pdf-writer/"
  s.description = "A pure Ruby PDF document creation library."
  s.has_rdoc = true
  s.authors  = ["Austin Ziegler","Ken Collins"]
  s.autorequire       = ["pdf/writer"]
  s.require_paths     = ["lib"]
  s.bindir            = "bin"
  s.executables       = ["techbook"]
  s.add_dependency('color', '>= 1.4.0')
  s.add_dependency('transaction-simple', '~> 1.3')             
  s.files = [
    "README",
    "LICENCE",
    "ChangeLog",
    "bin/techbook",
    "lib/pdf",
    "lib/pdf/charts",
    "lib/pdf/charts/stddev.rb",
    "lib/pdf/charts.rb",
    "lib/pdf/core_ext",
    "lib/pdf/core_ext/mutex.rb",
    "lib/pdf/math.rb",
    "lib/pdf/quickref.rb",
    "lib/pdf/simpletable.rb",
    "lib/pdf/techbook.rb",
    "lib/pdf/writer",
    "lib/pdf/writer/arc4.rb",
    "lib/pdf/writer/fontmetrics.rb",
    "lib/pdf/writer/fonts",
    "lib/pdf/writer/fonts/Courier-Bold.afm",
    "lib/pdf/writer/fonts/Courier-BoldOblique.afm",
    "lib/pdf/writer/fonts/Courier-Oblique.afm",
    "lib/pdf/writer/fonts/Courier.afm",
    "lib/pdf/writer/fonts/Helvetica-Bold.afm",
    "lib/pdf/writer/fonts/Helvetica-BoldOblique.afm",
    "lib/pdf/writer/fonts/Helvetica-Oblique.afm",
    "lib/pdf/writer/fonts/Helvetica.afm",
    "lib/pdf/writer/fonts/MustRead.html",
    "lib/pdf/writer/fonts/Symbol.afm",
    "lib/pdf/writer/fonts/Times-Bold.afm",
    "lib/pdf/writer/fonts/Times-BoldItalic.afm",
    "lib/pdf/writer/fonts/Times-Italic.afm",
    "lib/pdf/writer/fonts/Times-Roman.afm",
    "lib/pdf/writer/fonts/ZapfDingbats.afm",
    "lib/pdf/writer/graphics",
    "lib/pdf/writer/graphics/imageinfo.rb",
    "lib/pdf/writer/graphics.rb",
    "lib/pdf/writer/lang",
    "lib/pdf/writer/lang/en.rb",
    "lib/pdf/writer/lang.rb",
    "lib/pdf/writer/object",
    "lib/pdf/writer/object/action.rb",
    "lib/pdf/writer/object/annotation.rb",
    "lib/pdf/writer/object/catalog.rb",
    "lib/pdf/writer/object/contents.rb",
    "lib/pdf/writer/object/destination.rb",
    "lib/pdf/writer/object/encryption.rb",
    "lib/pdf/writer/object/font.rb",
    "lib/pdf/writer/object/fontdescriptor.rb",
    "lib/pdf/writer/object/fontencoding.rb",
    "lib/pdf/writer/object/image.rb",
    "lib/pdf/writer/object/info.rb",
    "lib/pdf/writer/object/outline.rb",
    "lib/pdf/writer/object/outlines.rb",
    "lib/pdf/writer/object/page.rb",
    "lib/pdf/writer/object/pages.rb",
    "lib/pdf/writer/object/procset.rb",
    "lib/pdf/writer/object/viewerpreferences.rb",
    "lib/pdf/writer/object.rb",
    "lib/pdf/writer/ohash.rb",
    "lib/pdf/writer/oreader.rb",
    "lib/pdf/writer/state.rb",
    "lib/pdf/writer/strokestyle.rb",
    "lib/pdf/writer.rb",
    "demo/chunkybacon.rb",
    "demo/code.rb",
    "demo/colornames.rb",
    "demo/demo.rb",
    "demo/gettysburg.rb",
    "demo/hello.rb",
    "demo/individual-i.rb",
    "demo/pac.rb",
    "demo/qr-language.rb",
    "demo/qr-library.rb",
    "images/bluesmoke.jpg",
    "images/chunkybacon.jpg",
    "images/chunkybacon.png",
    "demo/chunkybacon.rb",
    "demo/code.rb",
    "demo/colornames.rb",
    "demo/demo.rb",
    "demo/gettysburg.rb",
    "demo/hello.rb",
    "demo/individual-i.rb",
    "demo/pac.rb",
    "demo/qr-language.rb",
    "demo/qr-library.rb",
    "manual.pwd"
  ]
  s.rdoc_options = ["--title", "PDF::Writer", "--main", "README", "--line-numbers"]
  s.extra_rdoc_files = ["README", "ChangeLog", "LICENCE"]
end
