# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def num_baht(n)
    return "-" unless n
    return n==0 ? "-" : number_to_currency(n, :unit=>'', :precision=>0)
  end
  def num_satang(n)
    return "-" unless n
    nn = ((n-n.to_i)*100).to_i
    return nn==0 ? "-" : nn
  end
  def nbsp(n)
    "&nbsp;"*n
  end
  def b(s)
    "<b>#{s}</b>"
  end
  def home_page?
    request.path=='/'
  end
  def currency(n)
    number_to_currency(n,:unit=>'')
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
end
