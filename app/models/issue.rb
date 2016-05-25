require 'csv'
class Issue < ActiveRecord::Base
  acts_as_paranoid
has_one:chemical_type
has_one:party_order
has_one:chemical
has_many :production_report
has_many :labour
has_many :ireturn
belongs_to:order_summary
validates :order_no, :numericality=>true
validates :order_no, :presence=>true
#validates_presence_of :party, :machine_no, :chemicals_type ,:rg_material_issues,:shift,:insert_material,:chemicals,:message => "Fill this"

    def self.issue_report_to_csv(options = {})
       CSV.generate(options) do |csv|
         csv << column_names
          all.each do |issue|
            csv << issue.attributes.values_at(*column_names)
          end
       end
     end


end
