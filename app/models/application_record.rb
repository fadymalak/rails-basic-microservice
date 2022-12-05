class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  
  def as_json(options={})
  super(:except => [:id, :created_at, :updated_at])
end
end
