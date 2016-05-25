class MachineNo < ActiveRecord::Base
validates :machine_no_list, :presence => true
validates_uniqueness_of :machine_no_list, :case_sensitive => false
end
