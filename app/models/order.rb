class Order < ActiveRecord::Base
	has_one :scool
	has_one :course
	has_one :teacher
end
