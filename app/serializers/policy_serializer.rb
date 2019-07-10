class PolicySerializer < ActiveModel::Serializer
  attributes :id,
             :text,
             # :file_url,
             # :file_name,
             # :file_size,
             :company_id,
             :created_at,
             :updated_at

  # def file_url
  #   object.file.url
  # end

  # def file_name
  #   object.file.original_filename
  # end

  # def file_size
  #   object.file.size
  # end

end
