class WwwController < ApplicationController
  def index
    redirect_to :action => "posts"
    # render :text => "coming soon...", :layout => true 
  end
  def posts
    @posts= Post.all
  end
  def create_post
    post= Post.create $xvars[:enter_post][:post]
    img= $xvars[:enter_post][:post_pic_doc_id]
    scale_image(img) if img
    $xvars[:p][:return]= '/www/posts'
    GmaWsQueue.create :url=>songrit(:www)+"/ws/post",
      :body => post.to_xml, :status => 0, :gma_runseq_id=> $runseq.id 
    ws_dispatch
  end
  def update_post
    post = Post.update $xvars[:p][:id], $xvars[:edit_post][:post]
    $xvars[:p][:return]='/www/posts'
    img= $xvars[:edit_post][:post_pic_doc_id]
    scale_image(img) if img
    $xvars[:p][:return]= '/www/posts'
    GmaWsQueue.create :url=>songrit(:www)+"/ws/post",
      :body => post.to_xml, :status => 0, :gma_runseq_id=> $runseq.id 
    ws_dispatch
  end
  def rm_post
    Post.destroy $xvars[:p][:id]
    $xvars[:p][:return]='/www/posts'
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
