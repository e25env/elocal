class FinanceController < ApplicationController
  def budget
#    render :text => "hello"
  end
  def budget_detail
    @cats = Cat.all :conditions=>"fy=#{params[:fy]}"
    @plans = Plan.all :conditions=>"fy=#{params[:fy]}"
    render :layout=>false
  end
  def create_cat
    cat = Cat.new $xvars[:enter_cat][:cat]
    cat.budget= cat.balance= 0
    cat.save
  end
  def create_ptype
    ptype = Ptype.new $xvars[:enter_ptype][:ptype]
    ptype.budget= ptype.balance= 0
    ptype.save
  end
end
