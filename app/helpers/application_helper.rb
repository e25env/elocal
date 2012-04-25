# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  require "fusion_charts_helper"
  include FusionChartsHelper

  def palad
    User.find PALAD
  end
  def income_summary_maker
    User.find INCOME_SUMMARY_MAKER
  end
  #------------------------
  def leave_options
    [["ลาป่วย",1],["ลาคลอดบุตร",2],["ลากิจ",3],
      ["ลาพักผ่อน",4], ["ลาอุปสมบท",5], ["ลาราชการทหาร",6],
      ["ลาศึกษาต่อ",7], ["ลาองค์กรระหว่างประเทศ",8], ["ลาติดตามคู่สมรส",9],
      ["มาสาย",10], ["ขาดราชการ",11] ]
  end
  def province_prefix(province_id)
    return province_id==1 ? "" : "จังหวัด"
  end
  def district_prefix(province_id)
    return province_id==1 ? "" : "อำเภอ"
  end
  def underprivileged(u)
    case u
    when 1
      img= "seniors16.png"
    when 2
      img= "handicap16.png"
    when 3
      img= "aids16.png"
    end
    image_tag img
  end
  def sex_img(title)
    return title=="นาย" ? "male.png" : "female.png"
  end
  def sex(title)
    return title=="นาย" ? "ช" : "ญ"
  end
  def i2date(t,f)
    Time.utc t["#{f}(1i)"],t["#{f}(2i)"],t["#{f}(3i)"]
  end
  def num_baht(n)
    return "-" unless n
    baht= n.to_s.split('.')[0]
    # return baht=="0" ? "-" : baht
    baht.to_i
  end
  def num_satang(n)
    return "-" unless n
    satang = ((n-n.to_i)*100).to_s
    # return satang=="0" ? "-" : satang
    satang.to_i
  end
  def nbsp(n)
    "&nbsp;"*n
  end
  def home_page?
    request.path=='/'
  end
  def num(n, precision= 0)
    return n==0 ? "-" : number_to_currency(n,:unit=>'', :precision=>precision)
  end
  def currency(n)
    return n==0 ? "-" : number_to_currency(n,:unit=>'')
  end
  alias_method(:to_currency, :currency)
  
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args.map(&:to_s)) }
  end

  def javascript(*args)
    args = args.map { |arg| arg == :defaults ? arg : arg.to_s }
    content_for(:head) { javascript_include_tag(*args) }
  end
  def thai_baht(amount)
    return "" unless amount
    number = amount.to_s
    txtnum1 = ['ศูนย์','หนึ่ง','สอง','สาม','สี่','ห้า','หก','เจ็ด','แปด','เก้า','สิบ']
    txtnum2 = ['','สิบ','ร้อย','พัน','หมื่น','แสน','ล้าน']
    number.gsub!(",","")
    number.gsub!(" ","")
    number.gsub!("บาท","")
    numbers = number.split(".")
    if(numbers.length>2)
      return "มีเครื่องหมาย '.' มากกว่า 1 ตัว"
    end
    strlen = numbers.first.length
    convert = ""
    0.upto(strlen-1) do |i|
      n = numbers.first[i].chr.to_i
      if (n!=0)
        if ( i == (strlen-1) and n == 1)
          convert = convert + "เอ็ด"
        elsif ( i == (strlen-2) and n == 2)
          convert = convert + "ยี่"
        elsif ( i == (strlen-2) and n == 1)
          convert = convert + ""
        else
          #       puts "n = #{n.chr.to_i}"
          convert = convert + txtnum1[n]
        end
        convert = convert + txtnum2[strlen-i-1]
      end
    end
    convert = convert + "บาท"
    if(numbers[1]=="0" or numbers[1]=="00" or numbers[1]=="" or numbers[1]==nil)
      convert = convert + "ถ้วน"
    else
      strlen = numbers[1].length
      if strlen==1
        numbers[1] = numbers[1]+"0"
        strlen = numbers[1].length
      end
      0.upto(strlen-1) do |i|
        n = numbers.last[i].chr.to_i
        if(n!=0)
          if(i==(strlen-1) and n==1)
            convert = convert + 'เอ็ด'
          elsif(i==(strlen-2) and n==2)
            convert = convert + 'ยี่'
          elsif(i==(strlen-2) and n==1)
            convert = convert + ''
          else
            convert = convert + txtnum1[n]
          end
          convert = convert + txtnum2[strlen-i-1]
        end
      end
      convert = convert + 'สตางค์'
    end
    return convert
  end
  def process_services(app)
    # xml= get_app
    protected_services = []
    protected_modules = []
    mseq= 0
    @services= app.elements["//node[@TEXT='services']"] || REXML::Document.new
    @services.each_element('node') do |m|
      ss= m.attributes["TEXT"]
      code, name= ss.split(':', 2)
      next if code.blank?
      next if code.comment?
      module_code= name2code(code)
      # create or update to GmaModule
      gma_module= GmaModule.find_or_create_by_code module_code
      protected_modules << gma_module.id
      name = module_code if name.blank?
      gma_module.update_attributes :name=> name.strip, :seq=> mseq
      mseq += 1
      seq= 0
      m.each_element('node') do |s|
        service_name= s.attributes["TEXT"].to_s
        # t << "= #{module_code}::#{service_name}"
        scode, sname= service_name.split(':', 2)
        sname ||= scode; sname.strip!
        scode= name2code(scode)
        if scode=="role"
          gma_module.update_attribute :role, sname
          next
        end
        if scode.downcase=="link"
          role= get_option_xml("role", s) || ""
          rule= get_option_xml("rule", s) || ""
          gma_service= GmaService.find_or_create_by_module_and_code_and_name module_code, scode, sname
          gma_service.update_attributes :xml=>s.to_s, :name=>sname,
            :listed=>listed(s), :secured=>secured?(s),
            :gma_module_id=>gma_module.id, :seq => seq,
            :role => role, :rule => rule
          seq += 1
          protected_services << gma_service.id
        else
          # normal service
          step1 = s.elements['node']
          role= get_option_xml("role", step1) || ""
          rule= get_option_xml("rule", step1) || ""
          gma_service= GmaService.find_or_create_by_module_and_code module_code, scode
          gma_service.update_attributes :xml=>s.to_s, :name=>sname,
            :listed=>listed(s), :secured=>secured?(s),
            :gma_module_id=>gma_module.id, :seq => seq,
            :role => role, :rule => rule
          seq += 1
          protected_services << gma_service.id
        end
      end
    end
    GmaService.delete_all(["id NOT IN (?)",protected_services])
    GmaModule.delete_all(["id NOT IN (?)",protected_modules])
    # t.join("<br/>")
  end
  def process_roles(app)
    # t = ["process_roles"]
    # @app= get_app
    GmaRole.delete_all
    roles= app.elements["//node[@TEXT='roles']"] || REXML::Document.new
    roles.each_element('node') do |role|
      text= role.attributes['TEXT']
      c,n = text.split(': ')
      next if c.comment?
      GmaRole.create :code=>c.upcase, :name=>n, :gma_user_id=>get_user
      # t << "= #{text}"
    end
    # t.join("<br/>")
  end
end

module ActionView
  module Helpers
    class FormBuilder
      def date_select_senior(method)
        date_select method, :default => 60.years.ago, :use_month_names=>THAI_MONTHS, :order=>[:day, :month, :year], :start_year=>Time.now.year-110, :end_year=>Time.now.year-60
      end
      def date_select_year(method, o={})
        date_select method, :default => o[:default], :use_month_names=>THAI_MONTHS, :order=>[:day, :month, :year], :start_year=>o[:start_year], :end_year=>o[:end_year]
      end
    end
  end
end
