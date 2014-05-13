class Teacher < ActiveRecord::Base
		belongs_to :scool
	 mount_uploader :profile_image_url, AvatarUploader
end
