class Cost < ActiveRecord::Base
#validates_uniqueness_of :cost_per_unit, :case_sensitive => false
validates :cost_per_unit,:presence => true
belongs_to :production_report
end
