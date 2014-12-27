class Friendship < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :friend, class_name: "Usuario"
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller,model| controller.current_usuario }
end
