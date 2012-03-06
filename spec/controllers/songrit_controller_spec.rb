require 'spec_helper'

describe SongritController do
  it "should migrate old style views to splitview style" do
    v= GmaView.new %q(xxx <table id="doc" width="100%"><tr><td class="field-name">เลขที่ทะเบียนส่ง *</td><td><%= f.text_field :rnum, :style => "width:200px;" %></td><td style="width:50%;">&nbsp;</td></tr></table>yyy)
    v.splitview.should == %Q(xxx\n  <%= f.label :rnum, "เลขที่ทะเบียนส่ง *" %>\n  <%= f.text_field :rnum %>yyy)
    File.open('tmp/result.rhtml','w') do |f|
      f.puts(v.splitview)
    end
  end
  it "should process app/views/finance/income/enter_income_detail.rhtml" do
    s = File.read('app/views/finance/income/enter_income_detail.rhtml')
    v = GmaView.new s
    File.open('tmp/t1.rhtml','w') do |f|
      f.puts(s)
    end
    File.open('tmp/t2.rhtml','w') do |f|
      f.puts(v.splitview)
    end
  end
  it "should put description as placeholder" do
    s= %q( <table id="doc" width="100%"><tr><td class="field-name">รหัสบัญชี eLocal</td><td><%= f.text_field :code, :style => "width:200px;" %></td><td>ตัวเลขจำเพาะ 6 หลัก</td</tr></table>)
    v= GmaView.new s
    v.splitview.should == %Q(\n  <%= f.label :code, \"รหัสบัญชี eLocal\" %>\n  <%= f.text_field :code , :placeholder=>"ตัวเลขจำเพาะ 6 หลัก" %>)
  end
  it "should migrate date_field" do
    v= GmaView.new %q(xxx <table id="doc" width="100%"><tr><td class="field-name">เลขที่ทะเบียนส่ง *</td><td><%= f.date_select_thai :rnum, :style => "width:200px;" %></td><td style="width:50%;">&nbsp;</td></tr></table>yyy)
    v.splitview.should == %Q(xxx\n  <%= f.label :rnum, "เลขที่ทะเบียนส่ง *" %>\n  <%= f.date_field :rnum, "blackDays"=>[0,6] %>yyy)
    File.open('tmp/result.rhtml','w') do |f|
      f.puts(v.splitview)
    end
  end
  it "should migrate datetime_select_thai" do
    v= GmaView.new %q(xxx <table id="doc" width="100%"><tr><td class="field-name">วัน/เวลา ที่ส่ง *</td><td><%= f.datetime_select_thai :rnum, :style => "width:200px;" %></td><td style="width:50%;">&nbsp;</td></tr></table>yyy)
    v.splitview.should == %Q(xxx\n  <%= f.label :rnum, "วันที่ที่ส่ง *" %>\n  <%= f.date_field :rnum, "blackDays"=>[0,6] %>\n  <%= f.label :rnum_time, "เวลาที่ส่ง *" %>\n  <%= f.time_field :rnum_time %>yyy)
    File.open('tmp/result.rhtml','w') do |f|
      f.puts(v.splitview)
    end
  end
  it "should not modify other files" do
    s = File.read('app/views/public_works/construction_license/_report_request.rhtml')
    v = GmaView.new s
    v.splitview.should == s
  end
end
