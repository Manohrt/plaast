class PartyPurchase < ActiveRecord::Base
belongs_to:purchase
belongs_to :admin
validates :party_purchase_list, :presence => true
validates_uniqueness_of :party_purchase_list, :case_sensitive => false

end
