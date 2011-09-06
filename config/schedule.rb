# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :path, '/home/songrit/apps/elocal'
set :output, "#{path}/log/cron.log"

every 3.hours do
  # command "cd #{path} && heroku db:push postgres://postgres:songrit@localhost/elocal?encoding=utf8 --force"
  command "cd #{path} && git pull github master && bundle exec rake db:migrate"
  runner "GmaController.new.update_services"
end

#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
