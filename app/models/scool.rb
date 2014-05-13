class Scool < ActiveRecord::Base
	has_many :courses
	has_many :teachers
	mount_uploader :profile_image_url, CoverUploader

end
