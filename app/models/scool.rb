class Scool < ActiveRecord::Base
	has_many :courses
	has_many :teachers
end
