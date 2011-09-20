namespace :elocal do
  desc "backup db into doc/upload"
  task :backup do
    system %q(/usr/bin/pg_dump elocal | gzip -c > "doc/upload/db_elocal`date --rfc-3339=date`.sql.gz")
    puts "backup to doc/upload, to restore $gunzip db_elocalxxx.sql.gz $psql -d elocal -f db_elocalxxx.sql"
  end
  
  desc "cancel all pending tasks"
  task :cancel=>:environment do
    GmaXmain.update_all "status='X'", "status='I' or status='R'"
  end
end