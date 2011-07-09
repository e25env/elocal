class PublicWorksController < ApplicationController
  def index
    redirect_to :controller => "main", :action => "pending"
    # render :text => "coming soon...", :layout => true 
  end
  def create_construction
    construction= Construction.create $xvars[:enter][:construction]
    $xvars[:construction_id]= construction.id
  end
  
  def create_construction_detail
    construction_detail= ConstructionDetail.create $xvars[:enter_detail][:construction_detail]
  end

  def update_construction
    
  end
end
