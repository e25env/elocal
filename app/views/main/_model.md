
### <%= model %>

<% model_file= "#{Rails.root}/app/models/#{model}.rb" %>

#### model

<%= code_div File.read(model_file) %>

#### ฐานข้อมูล

<%= code_div model.camelize.constantize.columns.to_yaml %>
