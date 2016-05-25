class TypeOfPurchase < ActiveRecord::Base
validates_uniqueness_of :purchase_type,:case_sensitive => false
validates :purchase_type, :presence => true

end
