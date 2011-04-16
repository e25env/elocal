# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # config.time_zone = 'Bangkok'
  # config.active_record.default_timezone = "Bangkok"
  THAI_MONTHS = %w(มกราคม กุมภาพันธ์ มีนาคม เมษายน พฤษภาคม มิถุนายน กรกฎาคม สิงหาคม กันยายน ตุลาคม พฤศจิกายน ธันวาคม)
  APP_VERSION = '0.1'
  POST_TYPE = %w(ข่าว กิจกรรม รายงานการประชุม ท่องเที่ยว ประกาศ คำสั่ง จัดซื้อจัดจ้าง)
  config.action_controller.session_store = :active_record_store
  IMAGE_LOCATION = "doc/upload"
  CDN = false
  GMAP = false
  # disable Rails to add timestamp at end of image cause problem in heroku
  ENV["RAILS_ASSET_ID"] = ""
  # set_songrit :www, "http://elocal-www.heroku.com/ws/intranet_ping"
end
