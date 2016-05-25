class Admin < ActiveRecord::Base
has_one:chemical_type
has_one:party_order
has_one:machine_used
has_one:chemical
has_one:finished_goods_name
has_one:raw_material
has_one:party_purchase
has_one:nature_of_work
has_one:mould_no
has_one:reason_for_idle_time	
has_one:user
end
