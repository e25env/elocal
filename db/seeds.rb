unless Org.exists?
  puts "create sample Org"
  Org.create! :otype=> "องค์การบริหารส่วนตำบล",
    :otype_abbrev=> "อบต.",
    :name=> "บางตะไนย์",
    :address=> "43/8 หมู่ที่ 5",
    :district=> "ปากเกร็ด",
    :province=> "นนทบุรี ",
    :phone=> "0-2501-7321-2",
    :villages=> 5
end

['ม. 6','ปริญญาตรี','ปริญญาโท','ปริญญาเอก'].each do |e|
  EducationLevel.find_or_create_by_name(e)
end

unless Section.exists?
   puts "create sections"
   Section.create :code=>"01", :name => "สำนักงานปลัด อบต.", :doc_code=>"\340\270\233"
   Section.create :code=>"02", :name => "ส่วนการคลัง", :doc_code=>"\340\270\204"
   Section.create :code=>"03", :name => "ส่วนโยธา", :doc_code=>"\340\270\242"
   Section.create :code=>"04", :name => "ส่วนสาธารณสุขและสิ่งแวดล้อม", :doc_code=>"\340\270\252"
end