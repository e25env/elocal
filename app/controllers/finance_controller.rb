class FinanceController < ApplicationController
  def index
  end
  def buildings
    @buildings = Building.all
  end
  def lands
    @lands= Land.all
  end
  def create_land
    owner= Person.find_by_nid($xvars[:enter_land][:owner][:nid]) ||
      Person.create($xvars[:enter_land][:owner])
    utilizer= Person.find_by_nid($xvars[:enter_land][:utilizer][:nid]) ||
      Person.create($xvars[:enter_land][:utilizer])
    land = Land.new $xvars[:enter_land][:land]
    land.owner_id = owner.id
    land.utilizer_id = utilizer.id
    land.area_sqm= (land.area_rai*1600) + (land.area_ngan*400) + (land.area_wa*4)
    land.save
    $xvars[:p][:return]= "/finance/lands"
  end
  def balance
    @fixed_asset = 22199616.27
    @assets = []
    @assets << ["ทรัพย์สินตามงบทรัพย์สิน","",@fixed_asset,1]
    @assets << ["เงินสดและเงินฝากธนาคาร","",31488378.35]
    @assets << ["เงินอุดหนุนเฉพาะกิจฝากจังหวัด","",1810000]
    @assets << ["ลูกหนี้ - ภาษีโรงเรือนและที่ดิน","",57620]
    @assets << ["ลูกหนี้ - ภาษีบำรุงท้องที่","",5238]
    @assets << ["ลูกหนี้ - ภาษีป้าย","",5394]
    @assets << ["ลูกหนี้ - เงินยืมเงินสะสม","",11500]
    @total_asset = @assets.inject(0) {|sum,a| sum+a[2]}
    @current_asset = @total_asset - @fixed_asset
    @assets << ["","",@current_asset,1]
    @equity = []
    @equity << ["ทุนทรัพย์สิน","", @fixed_asset,1]
    @equity << ["เงินรับฝากต่างๆ","",1386033.54]
    @equity << ["ค่าใช้จ่ายค้างจ่าย (เบิกตัดปี)","",6584604.84]
    @equity << ["เงินอุดหนุนเฉพาะกิจค้างจ่าย","",1810000]
    @equity << ["เงินอุดหนุน - โครงการเศรษฐกิจชุมชน","",171306.27]
    @equity << ["เงินอุดหนุน - ค่าอาหารกลางวัน","",117000]
    @equity << ["ทุนสำรองเงินสะสม","",5869711.62]
    @equity << ["เงินสะสม","",17439474.08]
    @equity << ["","",@current_asset,1]
    @finance_head= User.finance_head
    @palat= User.palat
    @mayor= User.mayor
    render :layout => "print"
  end
  def banks
    @ftypes= ["เงินสะสม","เงินรายได้","เงินนอกงบประมาณ","เงินอื่นๆ"]
    @funds= [17268228.43,1718714.81,8156692.4,0]
    @etypes= ["จ่ายจากเงินอุดหนุน","จ่ายจากเงินรายได้","จ่ายจากเงินสะสม"]
    @expense_month_fixed = [2003000,1498533.06,5980912.27]
    @expense_month_invest = [0,0,0]
    @expense_month_total = @expense_month_fixed.sum+@expense_month_invest.sum
    @expense_acc_fixed = [2252000,3500976.64,6040957.27]
    @expense_acc_invest = [0,0,0]
    @expense_acc_total = @expense_acc_fixed.sum+@expense_acc_invest.sum
    @banks = []
    @banks << {:name=> "ธนาคารกรุงไทย", :btype=>"กระแสรายวัน", :balance=>0}
    @banks << {:name=> "ธนาคารกรุงไทย", :btype=>"ออมทรัพย์", :balance=>10875481.05}
    @banks << {:name=> "ธนาคารออมสิน", :btype=>"ออมทรัพย์", :balance=>1769497.71}
    @banks << {:name=> "ธนาคารออมสิน", :btype=>"ประจำ", :balance=>10935127.12}
    @banks << {:name=> "ธกส.", :btype=>"ประจำ", :balance=>3563529.76}
    @total = @banks.inject(0) { |sum,b| sum+b[:balance] }
    @finance_head= User.finance_head
    @palat= User.palat
    @mayor= User.mayor
    render :layout => "print"
  end
  def budget_expense
    @revenue_plan = 26528000
    @revenue_actual = 1358814.43
    @fixed_plan = 23022400
    @fixed_actual = 1498533.06
    @invest_plan = 3505600
    @invest_actual = 0
    @finance_head= User.finance_head
    @palat= User.palat
    @mayor= User.mayor
    render :layout => "print"
  end
  def daily
    @banks= Bank.all
  end
  def daily_print
    # sequence cash, bank, bank detail
    # mockup
    @finance_head = User.finance_head
    @cash_keeper  = {:name=>"น.ส. ธิติชญาณ์ เพ็ชรนพรัตน์", :position=>"นักวิชาการการเงินและบัญชี"}
    @carry = 27261351.64
    @expense = 117716
    @lines = []
    @lines << [nbsp(4)+"ยอดเงินสดคงเหลือยกมา",0]
    @lines << [nbsp(4)+"เงินสดรับ",0]
    @lines << [nbsp(4)+"เงินนำฝากธนาคาร",0]
    @lines << [nbsp(4)+"ยอดเงินสดคงเหลือยกไป",0,1]
    @lines << ["&nbsp;","&nbsp;"]
    @lines << [b("เงินฝากธนาคาร"),"&nbsp;"]
    @lines << [nbsp(4)+"ยอดเงินฝากธนาคารคงเหลือยกมา",@carry]
    @lines << [nbsp(4)+"เงินนำฝากธนาคาร",0]
    @lines << [nbsp(4)+"รายจ่าย",@expense]
    @lines << [nbsp(4)+"ยอดเงินฝากธนาคารคงเหลือยกไป",@carry-@expense,1]
    @lines << [nbsp(4)+"เช็คที่อนุมัติแล้ว ผู้มีสิทธิยังไม่มารับ จำนวน - ฉบับ เป็นเงิน - บาท","&nbsp;"]
    @lines << ["&nbsp;","&nbsp;"]
    @lines << [b("รายละเอียดยอดเงินฝากธนาคาร"),"&nbsp;"]
    @lines << ["1. เงินฝากธนาคาร กรุงไทย ออมทรัพย์ สาขานนทบุรี เลขที่ 108-0-47903-1",10875481.05]
    @lines << ["2. เงินฝากธนาคาร ออมสิน ออมทรัพย์ สาขาปากเกร็ด เลขที่ 01-206-20-083640-9",1598191.44]
    @lines << ["3. เงินฝากธนาคาร ออมสิน ออมทรัพย์ สาขาปากเกร็ด เลขที่ 01-206-20-112585-4",171306.27]
    @lines << ["4. เงินฝากธนาคาร ออมสิน ประจำ 6 เดือน สาขาปากเกร็ด เลขที่ 01-206-20-083640-9",10935127.12]
    @lines << ["5. เงินฝากธนาคาร ธกส.  ประจำ 3 เดือน สาขานนทบุรี เลขที่ 020-4-09104-3",3563529.76]
    @lines << [nbsp(4)+"รวมเงินฝากธนาคารคงเหลือยกไป",27143635.64,1]
    render :layout => "print"
  end
  def trial
    # sequence: assets, expense, income, equity
    @accounts = Account.find_all_by_atype(1)
    @accounts << Account.find_all_by_atype(5)
    @accounts << Account.find_all_by_atype(4)
    @accounts << Account.find_all_by_atype(3)
    @accounts.flatten!
    @finance_head= User.finance_head
    @palat= User.palat
    @mayor= User.mayor
    render :layout => "print"
  end
  def income
    @carry = 33345977.49
    @revenues = []
    @expenses = []
    @revenues << [2720000,46784,"ภาษีอากร",411000,0]
    @revenues << [311500,42715,"ค่าธรรมเนียม ค่าปรับ และใบอนุญาต",412000,10292]
    @revenues << [300000,60454.66,"รายได้จากทรัพย์สิน",413000,0]
    @revenues << [0,0,"รายได้จากสาธารณูปโภคและการพาณิชย์",414000,0]
    @revenues << [110500,500,"รายได้เบ็ดเตล็ด",415000,0]
    @revenues << [0,0,"รายได้จากทุน",416000,0]
    @revenues << [16186000,5137489.79,"ภาษีจัดสรร",421000,1348522.43]
    @revenues << [6400000,0,"เงินอุดหนุนทั่วไป",431000,0]
    @revenues << [500000,0,"เงินอุดหนุนกำหนดวัตถุประสงค์",441000,0]
    @revenues << ["",5287943.45,"","",1358814.43,1]
    @revenues << ["",1810000,"เงินอุดหนุนเฉพาะกิจฝากจังหวัด","0012",1810000]
    @revenues << ["",942000,"เงินอุดหนุนเฉพาะกิจ (หลักประกันผู้สูงอายุ)","0012",0]
    @revenues << ["",80500,"เงินอุดหนุนเฉพาะกิจ (สวัสดิการผู้พิการ)","0012",0]
    @revenues << ["",0,"ลูกหนี้ - ภาษีโรงเรือนและที่ดิน","0081",0]
    @revenues << ["",0,"ลูกหนี้ - ภาษีบำรุงท้องที่","0082",0]
    @revenues << ["",0,"ลูกหนี้ - ภาษีป้าย","0083",0]
    @revenues << ["",375500,"ลูกหนี้ - เงินยืมตามงบประมาณ","0090",227800]
    @revenues << ["",0,"เงินอุดหนุน - โครงการเศรษฐกิจชุมชน","0602",0]
    @revenues << ["",317500,"ลูกหนี้ - เงินยืมนอกงบประมาณ","0707",193000]
    @revenues << ["",261500,"ลูกหนี้ - เงินยืมเงินสะสม","0707",0]
    @revenues << ["",234693.69,"เงินรับฝาก","0900",114741.37]
    @revenues << ["",187775,"สินเชื่อ ธ.ออมสินหน้าฎีกา","0999",58441]
    
    @expenses << [3024090,1051650,"งบกลาง",510000,150620]
    @expenses << [1047840,243960,"เงินเดือน (ฝ่ายการเมือง)",521000,81320]
    @expenses << [3048000,503280,"เงินเดือนพนักงาน",220100,168050]
    @expenses << [116400,28620,"ค่าจ้างลูกจ้างประจำ",220400,9540]
    @expenses << [2233600,438510,"ค่าจ้างพนักงานจ้าง",220600,146170]
    @expenses << [1108000,0,"เงินประโยชน์ตอบแทนอื่นๆ",221100,0]
    @expenses << [885000,141892.5,"ค่าตอบแทน",531000,33713.5]
    @expenses << [7188050,862644,"ค่าใช้สอย",532000,786896]
    @expenses << [2503420,116210,"ค่าวัสดุ",533000,77262]
    @expenses << [487000,101470,"ค่าสาธารณูปโภค",534000,32221.46]
    @expenses << [1488700,0,"ค่าครุภัณฑ์",541000,0]
    @expenses << [2016900,0,"ค่าที่ดินและสิ่งก่อสร้าง",542000,0]
    @expenses << [1381000,12740.1,"เงินอุดหนุน",561000,12740.1]
    @expenses << ["",3500976.64,"","",1498533.06,1]
    @expenses << ["",487000,"ค่าใช้จ่ายค้างจ่าย (เบิกตัดปี)",600,0]
    @expenses << ["",1810000,"เงินอุดหนุนเฉพาะกิจค้างจ่าย",602,1810000]
    @expenses << ["",407500,"เงินอุดหนุนเฉพาะกิจ (หลักประกันผู้สูงอายุ)",602,181500]
    @expenses << ["",34500,"เงินอุดหนุนเฉพาะกิจ (สวัสดิการผู้พิการ)",602,11500]
    @expenses << ["",6040957.27,"เงินสะสม",700,5980912.27]
    @expenses << ["",261500,"ลูกหนี้ - เงินยืมเงินสะสม",704,0]
    @expenses << ["",317500,"ลูกหนี้ - เงินยืมเงินนอกงบประมาณ",707,193000]
    @expenses << ["",375500,"ลูกหนี้ - เงินยืมเงินตามงบประมาณ",900,221800]
    @expenses << ["",55495.94,"ภาษีหัก ณ ที่จ่าย",902,9452.32]
    @expenses << ["",363450,"เงินประกันสัญญา",903,0]
    @expenses << ["",0,"คชจ.ในการจัดเก็บภาษีบำรุงท้องที่ 5%",906,0]
    @expenses << ["",0,"ส่วนลดในการจัดเก็บภาษีบำรุงท้องที่ 6%",907,0]
    @expenses << ["",187775,"สินเชื่อ ธ.ออมสินหน้าฎีกา",999,58441]
    @sum_revenues = [26528000,9497412.14,"รวมรายรับ",3762796.8]
    @sum_expenses = [26528000,13842154.85,"รวมรายจ่าย",9965138.65]
    @deposit = 42472788.87
    @acc_expenses = @sum_expenses[1]
    @carry_over = 27143635.64
    
    render :layout => "print"
  end
  def expense_table
    # sequence central, overhead, investment, other, reserved
    # mockup
    @lines = []
    @lines << [b("1. รายจ่ายงบกลาง"),150620]
    @lines << [nbsp(2)+"1.1 ชำระหนี้เงินกู้",0]
    @lines << [nbsp(2)+"1.2 จ่ายตามข้อผูกพัน (ทุนการศึกษา, หลักประกันสุขภาพ)",0]
    @lines << [nbsp(2)+"1.3 เงินช่วยเหลืองบเฉพาะการ (ประกันสังคม, เบี้ยยังชีพคนชรา ผู้พิการ ผู้ป่วยเอดส์)",150620]
    @lines << [nbsp(2)+"1.4 เงินสำรองจ่าย",0]
    @lines << [nbsp(2)+"1.5 อื่นๆ (บำเหน็จบำนาญ)",0]
    @lines << [b("2. รายจ่ายประจำ"),1347913.06]
    @lines << [nbsp(2)+"2.1 เงินเดือน (ฝ่ายการเมือง)",81320]
    @lines << [nbsp(2)+"2.2 เงินเดือนพนักงาน",168050]
    @lines << [nbsp(2)+"2.3 ค่าจ้างประจำ",9540]
    @lines << [nbsp(2)+"2.4 ค่าจ้างชั่วคราว",146170]
    @lines << [nbsp(2)+"2.5 ค่าตอบแทน",33713.50]
    @lines << [nbsp(2)+"2.6 ค่าใช้สอย",786896]
    @lines << [nbsp(2)+"2.7 ค่าวัสดุ",77262]
    @lines << [nbsp(2)+"2.8 ค่าสาธารณูปโภค",32221.46]
    @lines << [nbsp(2)+"2.9 เงินอุดหนุน",12740.1]
    @lines << [nbsp(2)+"2.10 รายจ่ายอื่นๆ",0]
    @lines << [b("3. รายจ่ายเพื่อการลงทุน"),0]
    @lines << [nbsp(2)+"3.1 ค่าครุภัณฑ์",0]
    @lines << [nbsp(2)+"3.2 ค่าที่ดินและสิ่งก่อสร้าง",0]
    @lines << [b("4. รายจ่ายพิเศษ"),7983912.27]
    @lines << [nbsp(2)+"4.1 เงินอุดหนุนเฉพาะกิจ",1810000]
    @lines << [nbsp(2)+"4.2 เงินสะสม",5980912.27]
    @lines << [nbsp(2)+"4.3 เงินกู้",0]
    @lines << [nbsp(2)+"4.4 อื่นๆ (ผู้สูงอายุ, ผู้พิการของรัฐบาล)",193000]
    @lines << [b("5. รายจ่ายกันไว้เหลื่อมปี"),0]
    @lines << [nbsp(2)+"4.1 รายจ่ายงบกลาง",0]
    @lines << [nbsp(2)+"4.2 ค่าตอบแทนใช้สอยและวัสดุ",0]
    @lines << [nbsp(2)+"4.3 ค่าครุภัณฑ์ที่ดินและสิ่งก่อสร้าง",0]
    @lines << [nbsp(2)+"4.4 รายจ่ายอื่นๆ",0]
    @lines << [b("7. รวมรายจ่ายของท้องถิ่นทั้งสิ้น"),9482445.33]
    render :layout => "print"
  end
  def revenue_table
    # sequence local, assign, vat, support, retain
    # mockup
    @lines = []
    @lines << [b("1. รายได้ที่ท้องถิ่นจัดหาเอง"),10292]
    @lines << [nbsp(2)+"1.1 รายได้จากภาษีอากรที่ท้องถิ่นจัดหาเอง",0]
    @lines << [nbsp(4)+"1.1.1 ภาษีโรงเรือนและที่ดิน",0]
    @lines << [nbsp(4)+"1.1.2 ภาษีบำรุงท้องที่",0]
    @lines << [nbsp(4)+"1.1.3 ภาษีป้าย",0]
    @lines << [nbsp(4)+"1.1.4 อากรฆ่าสัตว์",0]
    @lines << [nbsp(4)+"1.1.5 อากรรังนกอีแอ่น",0]
    @lines << [nbsp(4)+"1.1.6 ภาษีบำรุงท้องถิ่นจากยาสูบ",0]
    @lines << [nbsp(4)+"1.1.7 ภาษีบำรุงท้องถิ่นจากน้ำมัน",0]
    @lines << [nbsp(4)+"1.1.8 ภาษีบำรุงท้องถิ่นจากโรงแรม",0]
    @lines << [nbsp(2)+"1.2 รายได้ที่ไม่ใช่ภาษีอากร",10292]
    @lines << [nbsp(4)+"1.2.1 ค่าธรรมเนียม ค่าปรับ และใบอนุญาต",10292]
    @lines << [nbsp(4)+"1.2.2 รายได้จากทรัพย์สิน",0]
    @lines << [nbsp(4)+"1.2.3 รายได้จากสาธารณูปโภค",0]
    @lines << [nbsp(4)+"1.2.4 รายได้เบ็ดเตล็ด",0]
    @lines << [nbsp(4)+"1.2.5 รายได้จากทุน",0]
    @lines << [b("2. รายได้จากการจัดสรรภาษีที่รัฐบาลเก็บให้หรือแบ่งให้ท้องถิ่น"),1348522.43]
    @lines << [nbsp(2)+"2.1 ภาษีมูลค่าเพิ่ม",1007104.23]
    @lines << [nbsp(4)+"- (1 ใน 9)",270514.36]
    @lines << [nbsp(4)+"- พรบ. อบต.",736589.87]
    @lines << [nbsp(2)+"2.2 ภาษีธุรกิจเฉพาะ",0]
    @lines << [nbsp(2)+"2.3 ภาษีสุราและเบียร์",90611.38]
    @lines << [nbsp(2)+"2.4 ภาษีสรรพสามิต",234884.05]
    @lines << [nbsp(2)+"2.5 ภาษีและค่าธรรมเนียมรถยนต์และล้อเลื่อน",0]
    @lines << [nbsp(2)+"2.6 ค่าธรรมเนียมจดทะเบียนอสังหาริมทรัพย์",0]
    @lines << [nbsp(2)+"2.7 ภาษีการพนัน",0]
    @lines << [nbsp(2)+"2.8 ค่าภาคหลวงแร่",15922.77]
    @lines << [nbsp(2)+"2.9 ค่าภาคหลวงปิโตรเลียม",0]
    @lines << [nbsp(2)+"2.10 อื่นๆ",0]
    @lines << [b("3. พรบ. กำหนดแผนฯ จากภาษีมูลค่าเพิ่ม"),0]
    @lines << [b("4. รายได้ที่รัฐบาลจัดสรรเพิ่มให้ (เงินอุดหนุน)"),1810000]
    @lines << [nbsp(2)+"4.1 เงินอุดหนุนทั่วไป",0]
    @lines << [nbsp(2)+"4.2 เงินอุดหนุนเฉพาะกิจ",1810000]
    @lines << [nbsp(2)+"4.3 เงินอุดหนุนพัฒนาจังหวัด",0]
    @lines << [b("5. รวมรายได้ของท้องถิ่นก่อนรวมเงินสะสมและเงินกู้ (1+2+3+4)"),3168814.43]
    @lines << [b("6. รายได้จากเงินสะสมและเงินกู้"),0]
    @lines << [nbsp(2)+"6.1 เงินสะสม",0]
    @lines << [nbsp(2)+"6.2 เงินกู้",0]
    @lines << [nbsp(2)+"6.3 อื่นๆ",0]
    @lines << [b("7. รวมรายได้ของท้องถิ่นทั้งสิ้น (5+6)"),3168814.43]
    render :layout => "print"
  end
  def accounts
    @accounts = Account.all
  end
  def account
    @account = Account.find_by_code params[:code]
  end
  def create_account
    account = Account.new $xvars[:enter][:account]
    account.balance= 0
    account.save
    $xvars[:p][:return]="/finance/accounts"
  end
  def update_account
    Account.update $xvars[:p][:id], $xvars[:edit][:account]
    $xvars[:p][:return]="/finance/accounts"
  end
  def create_account_trans
    account = Account.find $xvars[:p][:id]
    t = AccountTrans.create $xvars[:enter][:account_trans]
    if t.rtype==1
      # debit
      account.balance += t.amount
    else
      account.balance -= t.amount
    end
    account.save
    $xvars[:p][:return]="/finance/accounts"
  end
  def update_account_trans
    t = AccountTrans.find $xvars[:p][:id]
    account = Account.find t.account_id
    if t.rtype==1
      # debit, reverse
      account.balance -= t.amount
    else
      account.balance += t.amount
    end
    # apply new value
    rtype= $xvars[:edit][:account_trans][:rtype].to_i
    amount= $xvars[:edit][:account_trans][:amount].to_f
    if rtype==1
      # debit
      account.balance += amount
    else
      account.balance -= amount
    end
    account.save
    t = AccountTrans.update $xvars[:p][:id], $xvars[:edit][:account_trans]
    $xvars[:p][:return]="/finance/account?code=#{account.code}"
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
  def create_income
    income= Income.create $xvars[:enter_income][:income]
    $xvars[:income_id]= income.id
  end
  def create_income_detail
    income_detail= IncomeDetail.new $xvars[:enter_income_detail][:income_detail]
    income_detail.income_id= $xvars[:income_id]
    revenue= Revenue.first :conditions=>{:rcat_id=>income_detail.rcat_id, :rtype_id => income_detail.rtype_id}
    income_detail.revenue_id= revenue.id
    income_detail.save
  end
  def create_laas
    s = "ff.goto('http://www.laas.go.th/Default.aspx?menu=4E465433-EB5A-416A-8092-BBAE595C6CB7&control=list&screenname=REC_TAX_ALLOT&editable=true');"
    s << "ff.text_field(:name,'_ctl0:_ctl0:txtPayer:txtMain').set('test');"
    s << "ff.select_list(:id,'_ctl0__ctl0_ddlRecTypeName').select_value('9EC7EB15-83DD-4AE5-AD57-259F754DD3DA');"
    LaasQueue.create :xmain_id=>$xmain.id, :name=>$xmain.name,
      :description => "test", :script => s, :confirm => "จัดสรร",
      :status => 0, :retry => 0
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
  def update_cat
    Cat.update $xvars[:p][:id], $xvars[:edit_cat][:cat]
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
    render :text => prompt+@template.options_from_collection_for_select(cat.ptypes,:id,:name)
    #render :text => prompt+@template.options_from_collection_for_select(cat.ptypes_fy(params[:section],fiscal_year),:id,:name)
  end
  def get_rtypes
    rcat= Rcat.find params[:rcat]
#    prompt= "<option value="">..กรุณาเลือกประเภท</option>"
    # render :text => @template.options_from_collection_for_select(rcat.rtypes_fy(params[:fy]),:id,:name)
    render :text => @template.options_from_collection_for_select(rcat.rtypes,:id,:name)
  end
  def get_balance
    budget = Budget.first :conditions=>{:fy => fiscal_year, :ptype_id => params[:ptype], :fsection_id => params[:section] }
    balance = budget ? budget.balance : 0
      render :text => "คงเหลือ #{@template.number_to_currency(balance,:unit=>'')} บาท"
  end
end
