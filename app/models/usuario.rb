class Usuario < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise omniauth_providers: [:facebook, :twitter]

  has_many :posts
  has_many :friendships, foreign_key: "usuario_id", dependent: :destroy
  has_many :follows, through: :friendships, source: :friend
  has_many :followers_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :followers, through: :followers_friendships, source: :usuario

  def follow!(follow_id)
    friendships.create!(friend_id: follow_id)
  end

  def can_follow?(follow_id)
    not follow_id == self.id or friendships.where(friend_id: follow_id).size > 0
  end

  validates :username, presence: true, uniqueness: true, 
  length: {in: 5..20, too_short: "Tiene que tener al menos 5 caracteres.", too_long: "Maximo 20 caracteres."}

  def self.find_or_create_by_omniauth(data)
  	usuario = Usuario.where(provider: data[:provider], uid: data[:uid]).first
  	unless usuario
  		usuario = Usuario.create(
  			nombre: data[:nombre],
  			apellido: data[:apellido],
  			username: data[:username],
  			email: data[:email],
  			uid: data[:uid],
  			provider: data[:provider],
  			password: Devise.friendly_token[0,10]
  			)
  	end
    usuario
  end
end
