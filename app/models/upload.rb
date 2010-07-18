class Upload
  include MongoMapper::Document

  key :content, Binary
end