class PublicWorksController < ApplicationController
  def index
    redirect_to :controller => "main", :action => "pending"
    # render :text => "coming soon...", :layout => true 
  end
  def create_construction
    construction= Construction.new $xvars[:enter][:construction]
    site= construction.build_site $xvars[:enter][:site]
    site.save
    construction.site_id= site.id
    construction.save
    $xvars[:construction_id]= construction.id
  end
  
  def create_construction_detail
    construction_detail= ConstructionDetail.create $xvars[:enter_detail][:construction_detail]
  end

  def update_construction
    construction= Construction.find $xvars[:construction_id]
    construction.update_attributes $xvars[:enter_survey][:construction]
  end
end
