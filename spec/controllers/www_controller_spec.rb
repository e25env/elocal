require 'spec_helper'

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
    # @post= mock_model(Post)
    # @post.should_receive(:to_xml).and_return(@post.to_xml)
    $xvars= {:enter_post=>{:post=>{:subject=>'test'}}, :p=>{:return=>""}}
    $runseq= mock_model(GmaRunseq)
  end

  it "should create news" do
    # uploader= mock_uploader("doc/upload/f2", "image/jpg")
    # $xvars= {:enter_post=>{:post=>{:subject=>'test', :pic=>uploader}}, :p=>{:return=>""}}
    # Post.should_receive(:create)
    # post :create_post
  end
  it "should queue post" do
    GmaWsQueue.should_receive(:create)
    post :create_post
  end
  it "should post news to internet server" do
    RestClient.should_receive(:post)
    post :create_post
  end

end
