class Post < ActiveRecord::Base
  belongs_to :usuario
  has_many :attachments
  validates :titulo, presence: true, uniqueness: true
  include Picturable
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller,model| controller.current_usuario }
end
