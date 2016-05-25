class Chemical < ActiveRecord::Base
belongs_to:order_summary
belongs_to:issue
belongs_to:admin
validates_uniqueness_of :chemical_list, :case_sensitive => false
validates :chemical_list,:presence => true
end
