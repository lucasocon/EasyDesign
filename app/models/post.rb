class Post < ActiveRecord::Base
  belongs_to :usuario, dependent: :destroy
  has_many :attachments
  validates :titulo, presence: true, uniqueness: true
  before_save :set_default_price
  include Picturable
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller,model| controller.current_usuario }

  def set_default_price
    self.price ||= 0
  end
end
