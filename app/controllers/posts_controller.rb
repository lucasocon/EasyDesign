class PostsController < ApplicationController
	before_action :authenticate_usuario!, except: [:show, :index]

	expose(:posts)	
	expose(:post, attributes: :post_params)

	def index; end

	def show; end

	def new; end

	def edit; end

	def create
		params.permit!
		post.usuario_id = current_usuario.id
		if post.save
			redirect_to root_path
		else
			render :new
		end
	end

	def update
		params.permit!
   respond_to do |format|
     if post.update(post_params)
       format.html { redirect_to post, notice: 'Post was successfully updated.' }
       format.json { head :no_content }
     else
       format.html { render action: 'edit' }
       format.json { render json: post.errors, status: :unprocessable_entity }
     end
   end
  end

	def destroy
		post.destroy
		redirect_to posts_path, notice: "Fue eliminado con exito."
	end

	private
	def post_params
		params.require(:post).permit(:titulo, :contenido, :usuario_id, :file, :price)
	end
end
