class FinanceController < ApplicationController
  def create_bank
    bank = Bank.create $xvars[:enter_bank][:bank]
    return bank.id
  end
  def update_ptype
    Ptype.update $xvars[:p][:ptype], $xvars[:edit_ptype][:ptype]
    $xvars[:p][:return]='/finance/budget'
  end
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
  def budget_cat_detail
    @cats = Cat.all :conditions=>"fy=#{params[:fy]}"
    render :layout=>false
  end
  def budget_plan_detail
    @plans = Plan.all :conditions=>"fy=#{params[:fy]}"
    render :layout=>false
  end
  def create_payment
    payment= Payment.new $xvars[:enter_payment][:payment]
    payment.fy= fiscal_year
    payment.vat=0 unless payment.vat
    payment.deduct=0 unless payment.deduct
    payment.gsb=0 unless payment.gsb
    payment.total= payment.amount+payment.vat
    payment.net_amount = payment.total-payment.deduct-payment.gsb
    ptype= payment.ptype
    payment.total_budget= ptype.budget
    payment.budget= ptype.balance
    payment.net_budget= payment.budget-payment.total
    ptype.balance -= payment.total
    ptype.save
    payment.save
    set_songrit "payment_#{payment.fy}", payment.finance_num+1
    set_songrit "payment_#{payment.fy}_#{payment.section_id}", payment.num+1
    $xvars[:payment_id]= payment.id
  end
  def create_payment_details
    payment= Payment.find $xvars[:payment_id]
    $xvars[:enter_payment_detail][:payment_detail].each do |d|
      payment.payment_details.create d
    end
  end
  def create_cat
    cat = Cat.new $xvars[:enter_cat][:cat]
    cat.budget= cat.balance= 0
    cat.save
    $xvars[:p][:return]='/finance/budget'
  end
  def create_ptype
    ptype = Ptype.new $xvars[:enter_ptype][:ptype]
    ptype.save
    cat= ptype.cat
    cat.budget += ptype.budget
    cat.balance += ptype.balance
    cat.save
    $xvars[:p][:return]='/finance/budget'
  end
  def create_plan
    plan = Plan.new $xvars[:enter_plan][:plan]
    plan.budget= plan.balance= 0
    plan.save
    $xvars[:p][:return]='/finance/budget'
  end
  def create_task
    task = Task.new $xvars[:enter_task][:task]
    task.save
    plan = task.plan
    plan.budget += task.budget
    plan.balance += task.balance
    plan.save
    $xvars[:p][:return]='/finance/budget'
  end

  # ajax
  def get_payment_num
    payment_num = songrit "payment_#{params[:fy]}",1
    render :text => payment_num
  end
  def get_payment_section_num
    payment_section_num = songrit "payment_#{params[:fy]}_#{params[:section]}",1
    render :text => payment_section_num
  end
  def get_tasks
    plan= Plan.find params[:plan]
    render :text => @template.options_from_collection_for_select(plan.tasks,:id,:name)
  end
  def get_ptypes
    cat= Cat.find params[:cat]
    prompt= "<option value="">..กรุณาเลือกประเภท</option>"
    render :text => prompt+@template.options_from_collection_for_select(cat.ptypes,:id,:name)
  end
  def get_balance
    ptype= Ptype.find params[:ptype]
    render :text => "คงเหลือ #{@template.number_to_currency(ptype.balance,:unit=>'')} บาท"
  end
end
