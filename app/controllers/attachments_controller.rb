class AttachmentsController < ApplicationController
	expose(:attachments)
	expose(:attachment, params: :attachment_params)

	def index; end

	def new; end

	def create
		if attachment.save
			redirect_to root_path
		else
			render :new
		end
	end

	private
	def attachment_params
		params.require(:attachment).permit(:nombre, :extension, :post_id, :file)
	end
end
