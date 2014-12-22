class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise omniauth_providers: [:facebook, :twitter]

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
  end
end
