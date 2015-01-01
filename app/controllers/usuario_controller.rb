class UsuarioController < ApplicationController
  expose(:follows) { current_usuario.follows }
  expose(:followers) { current_usuario.followers }

  def show
    @usuario = Usuario.find(params[:id])
  end

  def follow
    respond_to do |format|
      if current_usuario.follow!(post_params[:friend_id])
        format.json {head :no_content}
      else
        format.json {render json: "Se encontraron errores", status: :unprocessable_entity}
      end
    end
  end

  private
  def post_params
    params.require(:usuario).permit(:friend_id)
  end
end
