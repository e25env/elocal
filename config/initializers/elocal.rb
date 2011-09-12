# lao specific
PROVINCE_ID= 3
DISTRICT_ID= 364
# do not define this constant if lao has multiple sub_districts, 
SUB_DISTRICT_ID= 426
# maximum number of moo (village)
MAX_MOO= 5

LAAS_USER = "abtbtnai714"
LAAS_PASSWORD = "318883"
LAAS_RETRY = 3

# GmaUser for permanent secretary
MAYOR = 3
PALAD = 4
HEAD_FINANCE = 5
FINANCE_HEAD = 5
HEAD_PUBLIC_WORKS = 5
INCOME_SUMMARY_MAKER = 2

FINANCE_SECTION = 2

# role for security officer (can search for everything)
SECURED_ROLE = 'S'
PER_PAGE = 25

ACCOUNT_TYPE = ['สินทรัพย์','เจ้าหนี้','ทุน','รายรับ','รายจ่าย']
MONTHS= ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฏาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม']
THAI_MONTHS = %w(มกราคม กุมภาพันธ์ มีนาคม เมษายน พฤษภาคม มิถุนายน กรกฎาคม สิงหาคม กันยายน ตุลาคม พฤศจิกายน ธันวาคม)

MAYOR_POSITION = "นายก"
CITY_LAW = "พระราชบัญญัติสภาตำบลและองค์การบริหารส่วนตำบล พ.ศ. 2537"
CITY_LAW_DECLARE = "27 ตุลาคม 2538" # ประกาศในราชกิจจานุเบกษา
CITY_LAW_EFFECTIVE = "26 ธันวาคม 2538" # มีผลใช้บังคับ
#HEAD_PUBLIC_WORKS = "นายเรวัติ ชุมแสง"

WWW = "http://elocal-www.heroku.com"
POST_TYPE = %w(ข่าว กิจกรรม รายงานการประชุม ท่องเที่ยว ประกาศ คำสั่ง จัดซื้อจัดจ้าง)

MSG_NEXT = "ดำเนินการต่อ &gt;"
CACHE_LOCATION  = File.join('config')
CACHE_FILE      = 'license.yml'
CACHE_PATH      = File.join(File.expand_path(CACHE_LOCATION), CACHE_FILE)
$license = Org.license
