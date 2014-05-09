class Course < ActiveRecord::Base
	belongs_to :scool
	has_one :teacher
end
