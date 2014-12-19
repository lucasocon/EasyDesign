class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise omniauth_providers: [:facebook, :twitter]

  def self.find_or_create_by_omniauth(auth)
  	usuario = Usuario.where(provider: auth[:provider], uid: auth[:uid]).first
  	unless usuario
  		usuario = Usuario.create(
  			nombre: auth[:nombre],
  			apellido: auth[:apellido],
  			username: auth[:username],
  			email: auth[:email],
  			uid: auth[:uid],
  			provider: auth[:provider],
  			password: Devise.friendly_token[0,10]
  			)
  	end
  end
end
