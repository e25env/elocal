class HealthController < ApplicationController
  def index
    @xmains= GmaXmain.all :conditions=>"status='R' or status='I' ", :order=>"created_at", :include=>:gma_runseqs
    render :template => "main/pending"
  end
end
