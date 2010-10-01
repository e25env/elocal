class FinanceController < ApplicationController
  def index
  end
  def laas
    @laases= LaasQueue.active
  end
  def submit_laas
    l = LaasQueue.find $xvars[:p][:id]
    ff= login_laas
    l.submit(ff)
    if ff.html =~ Regexp.new(l.confirm)
      l.update_attribute(:status, 1)
    else
      l.update_attributes :status=>2, :retry=> l.retry+1
      l.update_attribute(:status, 3) if (l.retry > LAAS_RETRY)
    end
    ff.close
    $xvars[:p][:return]= "/finance/laas"
  end
  def rm_laas
    l = LaasQueue.find $xvars[:p][:id]
    l.update_attribute(:status, 4)
    $xvars[:p][:return]='/finance/laas'
  end
  def revenue_detail
    @revenues= Revenue.all :conditions=>{:fy=>params[:fy]}, :order=>"rcat_id,rtype_id"
    render :layout=>false
  end
  def create_revenue
    revenue = Revenue.create $xvars[:enter_revenue][:revenue]
    $xvars[:p][:return]='/finance/revenue'
  end
  def rm_revenue
    Revenue.destroy $xvars[:p][:id]
    $xvars[:p][:return]='/finance/revenue'
  end
  def update_revenue
    Revenue.update $xvars[:p][:id], $xvars[:edit_revenue][:revenue]
    $xvars[:p][:return]='/finance/revenue'
  end
  def create_budget
    budget = Budget.create $xvars[:enter_budget][:budget]
    $xvars[:p][:return]='/finance'
  end
  def rm_budget
    Budget.destroy $xvars[:p][:id]
    $xvars[:p][:return]='/finance'
  end
  def update_budget
    Budget.update $xvars[:p][:id], $xvars[:edit_budget][:budget]
    $xvars[:p][:return]='/finance'
  end
  def ptype
    @ptype=Ptype.find params[:id]
    @budgets= Budget.all :conditions=>{:fy=>params[:fy], :ptype_id=>@ptype.id}
  end
  def rm_structure
    Plan.delete_all(:fy=>$xvars[:select_years][:fy])
    Task.delete_all(:fy=>$xvars[:select_years][:fy])
    Cat.delete_all(:fy=>$xvars[:select_years][:fy])
    Ptype.delete_all(:fy=>$xvars[:select_years][:fy])
    gma_notice "ลบผังบัญชีปีงบประมาณ #{$xvars[:select_years][:fy]} เรียบร้อยแล้ว"
  end
  def copy_structure
    # plan, task, cat, ptype, budget
    if Plan.first(:conditions=>{:fy=>$xvars[:select_years][:fy1]})
      gma_notice "ปีที่ต้องการมีอยู่แล้ว ไม่สามารถสร้างใหม่ได้"
    else
      Plan.all(:conditions=>{:fy=>$xvars[:select_years][:fy0]}).each do |p|
        pp= p.clone
        pp.fy= $xvars[:select_years][:fy1]
        pp.balance= pp.budget
        pp.save
      end
      Task.all(:conditions=>{:fy=>$xvars[:select_years][:fy0]}).each do |p|
        pp= p.clone
        plan = Plan.first :conditions=>['name=? and fy=?',pp.plan.name,$xvars[:select_years][:fy1]]
        pp.fy= $xvars[:select_years][:fy1]
        pp.balance= pp.budget
        pp.plan_id = plan.id
        pp.save
      end
      Cat.all(:conditions=>{:fy=>$xvars[:select_years][:fy0]}).each do |p|
        pp= p.clone
        pp.fy= $xvars[:select_years][:fy1]
        pp.balance= pp.budget
        pp.save
      end
      Ptype.all(:conditions=>{:fy=>$xvars[:select_years][:fy0]}).each do |p|
        pp= p.clone
        cat = Cat.first :conditions=>['name=? and fy=?',pp.cat.name,$xvars[:select_years][:fy1]]
        pp.fy= $xvars[:select_years][:fy1]
        pp.balance= pp.budget
        pp.cat_id = cat.id
        pp.save
      end
      gma_notice "คัดลอกผังบัญชีปีงบประมาณ #{$xvars[:select_years][:fy1]} เรียบร้อยแล้ว"
    end
  end
  def create_bank
    bank = Bank.create $xvars[:enter_bank][:bank]
    return bank.id
  end
  def update_plan
    Plan.update $xvars[:p][:plan], $xvars[:edit_plan][:plan]
    $xvars[:p][:return]='/finance/budget_plan'
  end
  def update_ptype
    Ptype.update $xvars[:p][:ptype], $xvars[:edit_ptype][:ptype]
    $xvars[:p][:return]='/finance/budget_cat'
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
    @fsections = Fsection.all
    render :layout=>false
  end
  def budget_cat_detail
    @cats = Cat.all
    render :layout=>false
  end
  def budget_plan_detail
    @plans = Plan.all :conditions=>"fy=#{params[:fy]}", :order=>:id
    render :layout=>false
  end
  def create_payment
    payment= Payment.new $xvars[:enter_payment][:payment]
    payment.fy= fiscal_year
    payment.total= payment.amount+payment.vat
    payment.net_amount = payment.total-payment.deduct-payment.gsb
#    ptype= payment.ptype
    budget= Budget.first :conditions=>['ptype_id=? AND fy=?',payment.ptype_id,payment.fy]
    payment.budget_id= budget.id
    payment.plan_id= budget.plan_id
    payment.total_budget= budget.budget
    payment.budget_before= budget.balance
    payment.net_budget= payment.budget_before-payment.total
    payment.plan_id= budget.plan_id
    budget.balance -= payment.total
    budget.save
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
    cat = Cat.create $xvars[:enter_cat][:cat]
    $xvars[:p][:return]='/finance/budget'
  end
  def create_ptype
    ptype = Ptype.create $xvars[:enter_ptype][:ptype]
    $xvars[:p][:return]='/finance/budget'
  end
  def create_plan
    plan = Plan.create $xvars[:enter_plan][:plan]
    $xvars[:p][:return]='/finance/budget'
  end
  def create_task
    task = Task.create $xvars[:enter_task][:task]
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
  def get_cats
    fsection= Fsection.find params[:section]
    prompt= "<option value="">..กรุณาเลือกหมวด</option>"
    render :text => prompt+@template.options_from_collection_for_select(fsection.cats_fy,:id,:name)
  end
  def get_ptypes
    cat= Cat.find params[:cat]
    prompt= "<option value="">..กรุณาเลือกประเภท</option>"
    render :text => prompt+@template.options_from_collection_for_select(cat.ptypes_fy(params[:section],fiscal_year),:id,:name)
  end
#  def get_ptypes0
#    cat= Cat.find params[:cat]
#    prompt= "<option value="">..กรุณาเลือกประเภท</option>"
#    render :text => prompt+@template.options_from_collection_for_select(cat.ptypes,:id,:name)
#  end
  def get_rtypes
    rcat= Rcat.find params[:rcat]
#    prompt= "<option value="">..กรุณาเลือกประเภท</option>"
    render :text => @template.options_from_collection_for_select(rcat.rtypes,:id,:name)
  end
  def get_balance
    budget = Budget.first :conditions=>{:fy => fiscal_year, :ptype_id => params[:ptype], :fsection_id => params[:section] }
    balance = budget ? budget.balance : 0
      render :text => "คงเหลือ #{@template.number_to_currency(balance,:unit=>'')} บาท"
  end
end
