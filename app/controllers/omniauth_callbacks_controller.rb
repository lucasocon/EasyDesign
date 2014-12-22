class OmniauthCallbacksController < ApplicationController
	def facebook
		auth = request.env["omniauth.auth"]
		data = {
			nombre: auth.info.first_name,
			apellido: auth.info.last_name,
			username: auth.info.username,
			email: auth.info.email,
			provider: auth.provider,
			uid: auth.uid
		}

		@usuario = Usuario.find_or_create_by_omniauth(data)
		
		if @usuario.persisted?
			sign_in_and_redirect @usuario, event: :authentication
		else
			session[:omniauth_errors] = @usuario.errors.full_messages.to_sentence unless @usuario.save
			session[:omniauth_data] = data

			redirect_to new_usuario_registration_url
		end
	end

	def twitter
		auth = request.env["omniauth.auth"]
		data = {
			nombre: auth.info.name,
			apellido: "",
			username: auth.info.nickname,
			email: "#{auth.info.nickname}@twitter.com",
			provider: auth.provider,
			uid: auth.uid
		}

		@usuario = Usuario.find_or_create_by_omniauth(data)
		
		if @usuario.persisted?
			sign_in_and_redirect @usuario, event: :authentication
		else
			session[:omniauth_errors] = @usuario.errors.full_messages.to_sentence unless @usuario.save
			session[:omniauth_data] = data

			redirect_to new_usuario_registration_url
		end
	end
end