class GmaView
  def initialize(s, path="")
    @path= path
    pattern= /\s+<table id="doc" width="100%">.+\/table>/m
    @table= pattern.match(s)
    @before, @after= s.split(pattern)
    @before ||= ""
    @after ||= ""
    @doc= Nokogiri::XML @table.to_s
  end
  def splitview
    text= [""]
    (@doc/'tr').each do |tr|
      tds= (tr/'td').map {|td| td.text}
      m= /:(.+?)[,\s]/.match(tds[1])
      f= /%=(.+)%>/m.match(tds[1])
      field= f[1].to_s
      ft= /f.(.+?)\s/.match(field)
      # debugger unless ft
      unless (m and f and ft)
        text << tr.text.gsub('%=','<%=')
        next
      end
      method= m[1]
      field_nostyle= field.sub(/, :style => .width:.+px../,'')
      field_type = ft[1] # "text_field"
      # debugger
      case field_type
      when "date_select_thai"
        text << %Q(  <%= f.label :#{method}, "#{tds[0]}" %>)
        text << %Q(  <%= f.date_field :#{method}, "blackDays"=>[0,6] %>)
      when "datetime_select_thai"
        suffix= /วัน\/เวลา (.+)/.match(tds[0])
        # debugger
        if suffix
          text << %Q(  <%= f.label :#{method}, "วันที่#{suffix[1]}" %>) 
        else
          text << %Q(  <%= f.label :#{method}, "#{tds[0]}" %>)
        end
        text << %Q(  <%= f.date_field :#{method}, "blackDays"=>[0,6] %>)
        if suffix
          text << %Q(  <%= f.label :#{method}_time, "เวลา#{suffix[1]}" %>)
        else
          text << %Q(  <%= f.label :#{method}_time, "#{tds[0]}" %>)          
        end
        text << %Q(  <%= f.time_field :#{method}_time %>)
      else
        if tds[2].blank?
          text << %Q(  <%= f.label :#{method}, "#{tds[0]}" %>)
          text << %Q(  <%=#{field_nostyle}%>)
        else
          text << %Q(  <%= f.label :#{method}, "#{tds[0]}" %>)
          text << %Q(  <%=#{field_nostyle}, :placeholder=>"#{tds[2]}" %>)
        end
      end
    end
    if text == [""]
      return @before+@table.to_s
    else
      @before+ text.join("\n")+ @after
    end
  end
end
