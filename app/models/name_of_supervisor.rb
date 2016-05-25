class NameOfSupervisor < ActiveRecord::Base
validates_uniqueness_of :name_of_supervisor_list, :case_sensitive => false
validates :name_of_supervisor_list, :presence=>true

end
