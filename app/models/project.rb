class Project < ActiveRecord::Base
  validates :source_remote_id, numericality: { only_integer: true }
end
