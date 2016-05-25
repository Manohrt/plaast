class ProductionReport < ActiveRecord::Base
#acts_as_paranoid sentinel_value: DateTime.new(0)

   acts_as_paranoid

belongs_to:issue
has_many:labour
has_many:finished
has_many:order_summary
has_many :cost
has_many :rejection_reason
#validates_presence_of :finished_goods_name,:total_no_of_items_produced,:weight_per_item,:total_weight_consumed,:standard_weight,:no_of_kgs_used_for_production,:variance,:rejected_nos,:rejected_nos_wt_for_re_grounding, :lumps, :message => "fill this"

def self.production_report_to_csv(options = {})
       CSV.generate(options) do |csv|
         csv << column_names
          all.each do |production_report|
            csv << production_report.attributes.values_at(*column_names)
          end
       end
 end

end
