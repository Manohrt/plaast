class Finished < ActiveRecord::Base
  acts_as_paranoid

belongs_to :production_report
belongs_to :labour
end
