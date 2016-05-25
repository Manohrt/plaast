class InsertMaterial < ActiveRecord::Base
  validates_uniqueness_of :insert_material_list, :case_sensitive => false
  validates :insert_material_list, :presence=>true

end
