class Org < ActiveRecord::Base
  def self.full_name
    o= self.last
    "#{o.otype}#{o.name}"
  end
  def self.abbrev_name
    o= self.last
    "#{o.otype_abbrev}. #{o.name}"
  end
  def self.head_report
    org= self.last
    "#{org.otype}#{org.name} อำเภอ#{org.district} จังหวัด#{org.province}"
  end
  def self.logo
    return File.exist?('public/images/logo.png') ? "logo.png" : "logo_elocal.png"
  end
  def self.license
    if File.exists?(CACHE_PATH)
      l = License.new
      require 'key'
      public_key_file = 'config/pob.public.pem';
      public_key= Key.new(public_key_file)
      license = public_key.pub_decrypt(l.license)
      return license
    else
      return "starter"
    end
  rescue
    return "starter"
  end
  def self.licensed?
    $license.split(':')[0]=="elocal" || heroku?
  end
end
