class Purchase < ActiveRecord::Base
  acts_as_paranoid
belongs_to :purchase
#validates_presence_of :party, :message => "Fill this"

def self.purchase_report_to_csv(options = {})
       CSV.generate(options) do |csv|
         csv << column_names
          all.each do |purchase|
            csv << purchase.attributes.values_at(*column_names)
          end
       end
     end


end
