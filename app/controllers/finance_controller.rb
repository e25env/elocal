class FinanceController < ApplicationController
  def budget
#    render :text => "hello"
  end
  def budget_adj
    Cat.all.each do |cat|
      budget = balance = 0
      cat.ptypes.each do |ptype|
        budget += ptype.budget
        balance += ptype.balance
      end
      cat.budget = budget
      cat.balance = balance
      cat.save
    end
    Plan.all.each do |plan|
      budget = balance = 0
      plan.tasks.each do |task|
        budget += task.budget
        balance += task.balance
      end
      plan.budget = budget
      plan.balance = balance
      plan.save
    end
    redirect_to :action => "budget"
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
    ptype.save
    cat= ptype.cat
    cat.budget += ptype.budget
    cat.balance += ptype.balance
    cat.save
  end
  def create_plan
    plan = Plan.new $xvars[:enter_plan][:plan]
    plan.budget= plan.balance= 0
    plan.save
  end
  def create_task
    task = Task.new $xvars[:enter_task][:task]
    task.save
    plan = task.plan
    plan.budget += task.budget
    plan.balance += task.balance
    plan.save
  end
end
