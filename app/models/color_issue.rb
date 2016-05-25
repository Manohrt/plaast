class ColorIssue < ActiveRecord::Base
validates_uniqueness_of :color_issue_list, :case_sensitive => false
validates :color_issue_list, :uniqueness => true
end
