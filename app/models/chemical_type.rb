class ChemicalType < ActiveRecord::Base
belongs_to :order_summary
belongs_to :issue
belongs_to :admin
validates_uniqueness_of :chemical_type_list, :case_sensitive => false
validates :chemical_type_list,:presence => true
end
