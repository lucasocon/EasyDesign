class PostsController < ApplicationController
	#before_action :authenticate_usuario!, except: [:show, :index]

	expose(:posts)	
	expose(:post, attributes: :post_params)

	def index; end

	def show; end

	def new; end

	def create
		params.permit!
		if current_usuario.posts << post
			redirect_to root_path
		else
			render :new
		end
	end

	def destroy
		post.destroy
		redirect_to posts_path, notice: "Fue eliminado con exito."
		
	end

	private
	def post_params
		params.require(:post).permit(:titulo, :contenido, :extension, :usuario_id)
	end
end