class Webinar < ActiveRecord::Base
  	belongs_to :user

  	validates_presence_of :name
  	validates_presence_of :filepath

  	mount_uploader :filepath, UserFileUploader
  	
end
