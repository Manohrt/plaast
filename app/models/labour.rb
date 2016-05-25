class Labour < ActiveRecord::Base
  acts_as_paranoid
has_one:mould_no
#has_one:party_order
has_one:machine_used
has_one:nature_of_work
#has_one:finished_goods_name
has_many:finished
has_one:reason_for_idle_time
belongs_to:order_summary
belongs_to:issue
belongs_to:production_report
#validates_presence_of :party, :mach_used, :mould, :shift, :nature, :goods_finished, :reasons_for_idle, :supervisor_name, :message => "Fill this"
def self.labour_to_csv(options = {})
       CSV.generate(options) do |csv|
         csv << column_names
          all.each do |labour|
            csv << labour.attributes.values_at(*column_names)
          end
       end
end
end
