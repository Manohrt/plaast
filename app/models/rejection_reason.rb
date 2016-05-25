class RejectionReason < ActiveRecord::Base
  validates_uniqueness_of :rejection_reason_list ,:case_sensitive => false
#  validates :rejection_reason_list
  belongs_to :production_report

end
