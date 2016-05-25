class MouldNo < ActiveRecord::Base
belongs_to:labour
belongs_to :admin
#validates :mould_no_list, :uniqueness => true
validates :mould_no_list, :presence=>true
end
