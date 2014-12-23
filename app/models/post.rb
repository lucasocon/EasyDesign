class Post < ActiveRecord::Base
  belongs_to :usuario
  has_many :attachments
  validates :titulo, presence: true, uniqueness: true
 
end
