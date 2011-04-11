require 'spec_helper'

describe WwwController do

  it "should create news" do
    @f= File.read("public/images/account.png")
    @post= mock_model(Post)
    @media= mock_model(Media)
    $xvars= {:enter_post=>{:post=>{:subject=>'test'}, :media=>[@f]}}
    Post.should_receive(:create).and_return(@post)
    @post.should_receive(:media).and_return(@media)
    @media.should_receive(:create)
    post :create_post
  end
  it "should post news to internet server"
  it "should queue post if network not available"

end
