class PostsController < ApplicationController
	before_action :authenticate_usuario!, except: [:show, :index]

	expose(:posts)	
	expose(:post, attributes: :post_params)

	def index; end

	def show; end

	def new; end

	def create
		post.usuario_id = current_usuario.id
		if post.save
			redirect_to root_path
		else
			render :new
		end
	end

	def destroy
		post.destroy
		redirect_to posts_path, notice: "Fue eliminado con exito."
		
	end

	protected
	def post_params
		params.require(:post).permit(:titulo, :contenido, :usuario_id, :file)
	end
end
