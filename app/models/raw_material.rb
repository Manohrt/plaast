class RawMaterial < ActiveRecord::Base
 belongs_to:order_summary
 belongs_to :admin
#validates :raw_material_list, :uniqueness => true
validates :raw_material_list, :presence=>true
validates_uniqueness_of :raw_material_list, :case_sensitive => false

end
