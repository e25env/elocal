class WwwController < ApplicationController
  def index
    redirect_to :action => "posts"
    # render :text => "coming soon...", :layout => true 
  end
  def posts
    @posts= Post.all
  end
  def create_post
    post= Post.new $xvars[:enter_post][:post]
    img= $xvars[:enter_post][:post_pic_doc_id]
    if img
      scale_image(img)
      @pic_postimg= postimg(File.join(IMAGE_LOCATION,"f#{img}"))
      post.pic_postimg= @pic_postimg
    end
    post.save
    $xvars[:p][:return]= '/www/posts'
    GmaWsQueue.create :url=>songrit(:www)+"/ws/post",
      :body => post.to_xml, :status => 0, :gma_runseq_id=> $runseq.id 
    ws_dispatch
  end
  def update_post
    post = Post.update $xvars[:p][:id], $xvars[:edit_post][:post]
    img= $xvars[:edit_post][:post_pic_doc_id]
    if img
      scale_image(img)
      @pic_postimg= postimg(File.join(IMAGE_LOCATION,"f#{img}"))
      post.pic_postimg= @pic_postimg
    end
    $xvars[:p][:return]= '/www/posts'
    GmaWsQueue.create :url=>songrit(:www)+"/ws/post",
      :body => post.to_xml, :status => 0, :gma_runseq_id=> $runseq.id 
    ws_dispatch
  end
  def rm_post
    Post.destroy $xvars[:p][:id]
    $xvars[:p][:return]='/www/posts'
    GmaWsQueue.create :url=>songrit(:www)+"/ws/rm_post",
      :body => {:id=> $xvars[:p][:id]}.to_xml(:root=>'post'), 
      :status => 0, :gma_runseq_id=> $runseq.id 
    ws_dispatch
  end
  
  private
  def scale_image(img)
    max_cols= 340
    f= "#{IMAGE_LOCATION}/f#{img}"
    img = Magick::Image.read(f).first
    if img.columns > max_cols
      img = img.change_geometry(max_cols){|cols,rows,i| i.resize!(cols,rows)}
      img.write(f)
    end
    img.destroy!
  end
  
end
