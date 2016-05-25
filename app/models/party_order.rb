class PartyOrder < ActiveRecord::Base
  belongs_to:order_summary
  belongs_to:labour
  belongs_to:issue
  belongs_to :admin
validates :party_order_list, :presence => true
validates_uniqueness_of :party_order_list, :case_sensitive => false

end
