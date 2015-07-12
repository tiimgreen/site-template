class Setting < ActiveRecord::Base
  validates :key,         presence: true
  validates :value,       presence: true
  validates :pretty_name, presence: true
end
