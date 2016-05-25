class NatureOfWork < ActiveRecord::Base
belongs_to:labour
belongs_to :admin
#validates :nature_of_work_list, :uniqueness => true
validates :nature_of_work_list, :presence=>true
validates_uniqueness_of :nature_of_work_list, :case_sensitive => false

end
