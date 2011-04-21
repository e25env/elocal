require 'spec_helper'
require 'webmock/rspec'
include WebMock

def mock_uploader(file, type = 'image/png')
  # filename = "%s/%s" % [ File.dirname(__FILE__), file ]
  filename = Rails.root.join(file)
  uploader = ActionController::UploadedStringIO.new
  uploader.original_path = filename
  uploader.content_type = type
  def uploader.read
    File.read(original_path)
  end
  def uploader.size
    File.stat(original_path).size
  end
  uploader
end

describe WwwController do
  before do
    controller.stub(:songrit).with(:www).and_return("http://elocal-www.local")
    controller.stub(:postimg).and_return("http://www.postimg.com/34000/photo-33829.jpg")
    $xvars= {:enter_post=>{:post_pic_doc_id => 138, :post=>{:subject=>'test', 
      :pic=>'http://localhost:3000/engine/document/138'}},
      :p=>{:return=>""}}
    $runseq= mock_model(GmaRunseq)
    @post= stub_model(Post, $xvars[:enter_post][:post])
    @post.stub(:save).and_return(@post)
    @ws_queue= mock_model GmaWsQueue, 
      :url=>"http://elocal-www.local/ws/post",
      :body => @post.to_xml, :status => 0, :gma_runseq_id=> $runseq.id 
    stub_request(:post, @ws_queue.url).to_return(:body => "ok", :status => 200)
  end

  it "should create news" do
    # uploader= mock_uploader("doc/upload/f2", "image/jpg")
    Post.should_receive(:new).and_return(@post)
    # should post news to internet server
    GmaWsQueue.should_receive(:active).and_return([@ws_queue])
    RestClient.should_receive(:post)
    post :create_post
    # should post to postimg or facebook(http://nhw.pl/wp/2008/06/13/uploading-photos-to-facebook-with-rfacebook)"
    assigns[:pic_postimg].should =~ /www.postimg.com\/\d+\/photo-\d+/
  end
  it "should edit news" do
    $xvars= {:edit_post=>{:post_pic_doc_id => 138, :post=>{:subject=>'test', 
      :pic=>'http://localhost:3000/engine/document/138'}},
      :p=>{:return=>"", :id=>@post.id}}
    Post.should_receive(:update).and_return(@post)
    post :update_post
  end
  it "should delete news"

end
