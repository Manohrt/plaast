class Reground < ActiveRecord::Base
validates_uniqueness_of :reground_list, :case_sensitive => false
validates :reground_list, :presence => true

end
