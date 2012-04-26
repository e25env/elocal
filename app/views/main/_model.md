
h4. <%= model %>

<% model_file= "#{Rails.root}/app/models/#{model}.rb" %>

h5. model

<%= code_div File.read(model_file) %>

h5. ฐานข้อมูล

<%= code_div model.camelize.constantize.columns.to_yaml %>
