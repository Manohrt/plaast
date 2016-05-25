class FinishedGoodsName < ActiveRecord::Base
belongs_to:labour
belongs_to:order_summary
belongs_to :admin
validates_uniqueness_of :finished_goods_name_list, :case_sensitive => false
#validates :finished_goods_name_list, :uniqueness => true
validates :finished_goods_name_list, :presence=>true
#goods_scope :order_by,lambda {|o|{:order=>o}}
end
