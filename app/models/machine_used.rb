class MachineUsed < ActiveRecord::Base
belongs_to:labour
belongs_to :admin
validates :machine_used_list,  :presence => true
validates_uniqueness_of :machine_used_list, :case_sensitive => false

end
