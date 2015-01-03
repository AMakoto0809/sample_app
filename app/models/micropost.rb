class Micropost < ActiveRecord::Base
	#Code12.7
	belongs_to :user
	#Code12.11
	default_scope -> { order('created_at DESC') }
	#Code12.15
	validates :content,presence: true,length: { maximum: 140 }
	#Code12.4
	validates :user_id,presence: true
end