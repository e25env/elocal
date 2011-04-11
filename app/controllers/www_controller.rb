class WwwController < ApplicationController
  def index
    render :text => "coming soon...", :layout => true 
  end
  def posts
    @posts= Post.all
  end
  def create_post
    post= Post.create $xvars[:enter_post][:post]
    $xvars[:p][:return]= '/www/posts'
  end
  def update_post
    Post.update $xvars[:p][:id], $xvars[:edit_post][:post]
    $xvars[:p][:return]='/www/posts'
  end
  def rm_post
    Post.destroy $xvars[:p][:id]
    $xvars[:p][:return]='/www/posts'
  end
end
