class SongritController < ApplicationController
  include ActionView::Helpers::DebugHelper
  include ERB::Util
  require "csv"
  require "hpricot"
  require "open-uri"
#  require 'nokogiri'
#  require 'mechanize'

  def test_document
#    path = defined?(IMAGE_LOCATION) ? IMAGE_LOCATION : "tmp"
    if GmaDoc.exists?(params[:id])
      doc = GmaDoc.find params[:id]
      if %w(output temp).include?(doc.content_type)
        render :text=>doc.data_text
      else
#        data= read_binary("#{path}/f#{params[:id]}")
#        send_data(data, :filename=>doc.filename, :type=>doc.content_type, :disposition=>"inline")
        send_data(Upload.find(doc.data_text).content.to_s, :filename=>doc.filename, :type=>doc.content_type, :disposition=>"inline")
      end
    else
      data= read_binary("public/images/file_not_found.jpg")
      send_data(data, :filename=>"img_not_found.png", :type=>"image/png", :disposition=>"inline")
    end
  end

  def test_mongo
    u = Upload.create :content=>'hello'
    render :text => debug(u)
  end
  def a2waypoint(s='hello *songrit, how are you?')
    render :text => s.gsub!(/\*([\w]+)(\W)?/, '<a href="/\1">*\1</a>\2')
  end
  def test_user_agent
    render :text => request.user_agent
  end
  def test_rmagick
    img_orig = Magick::Image.read("tmp/f6").first
#    img = img_orig.matte_floodfill("white")
    img_orig.write("tmp/f0.gif")
    render :text => "done"
  end
  def test_pic
    xmain = GmaXmain.find 24
    @xvars = xmain.xvars
    doc = GmaDoc.find @xvars[:add][:waypoint_pic_doc_id]
    from = "tmp/f#{@xvars[:add][:waypoint_pic_doc_id]}"
    to = "tmp/#{doc.filename}"
    FileUtils.cp from, to
    url = postimg(to)
    render :text => url
  end
  def test_const
    a= defined?(IMAGE_LOCATION) ? "has" : "undefined"
    render :text => a
  end
  def test_postimg
    p = postimg("/media/DATA/pictures/2print/IMAG0742.jpg")
    render :text => "<a href='#{p}'>#{p}</a>"
  end
end

