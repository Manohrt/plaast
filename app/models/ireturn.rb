class Ireturn < ActiveRecord::Base
  acts_as_paranoid

belongs_to :issue
    def self.ireturn_report_to_csv(options = {})
       CSV.generate(options) do |csv|
         csv << column_names
          all.each do |ireturn|
            csv << ireturn.attributes.values_at(*column_names)
          end
       end
    end
end
