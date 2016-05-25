require 'csv'
class Import
  class << self
    def from_csv
      CSV.foreach("#{Rails.root}/log/data.csv") do |csv|
        raw_material=RawMaterial.new(:raw_material_list=>csv[0])
        raw_material.save(:validate=>true)
        chemical=Chemical.new(:chemical_list=>csv[1])
        chemical.save(:validate=>true)
        machine_used=MachineUsed.new(:machine_used_list=>csv[2])
        machine_used.save(:validate=>true)
        mould_no=MouldNo.new(:mould_no_list=>csv[3])
        mould_no.save(:validate=>true)
        finished_goods_name=FinishedGoodsName.new(:finished_goods_name_list=>csv[4])
        finished_goods_name.save(:validate=>true)
        party_order=PartyOrder.new(:party_order_list=>csv[5])
        party_order.save(:validate=>true)
        nature_of_work=NatureOfWork.new(:nature_of_work_list=>csv[6])
        nature_of_work.save(:validate=>true)
        reason_for_idle_time=ReasonForIdleTime.new(:reason_for_idle_time_list=>csv[7])
        reason_for_idle_time.save(:validate=>true)
        chemical_type=ChemicalType.new(:chemical_type_list=>csv[8])
        chemical_type.save(:validate=>true)
        party_purchase=PartyPurchase.new(:party_purchase_list=>csv[9])
        party_purchase.save(:validate=>true)
        reground=Reground.new(:reground_list=>csv[10])
        reground.save(:validate=>true)
        type_of_purchase=TypeOfPurchase.new(:purchase_type=>csv[11])
        type_of_purchase.save(:validate=>true)
        insert_material=InsertMaterial.new(:insert_material_list=>csv[12])
        insert_material.save(:validate=>true)
      end
    end
  end
end
