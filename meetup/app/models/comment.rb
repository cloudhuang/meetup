class Comment < ActiveRecord::Base
	belongs_to :issue
	belongs_to :user

	validates :content, presence: true
end
