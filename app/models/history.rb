class History < ActiveRecord::Base
  belongs_to :stock
  belongs_to :user
  belongs_to :event
end
