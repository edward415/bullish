class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :stock
  has_one :history
  
  default_scope { order('created_at DESC') }
  
end
