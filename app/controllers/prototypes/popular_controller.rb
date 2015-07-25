class Prototypes::PopularController < ApplicationController
  def index
    @prototypes = Prototype.order('likes_count DESC').page(params[:page]).per(3)
    render "prototypes/index"
  end
end
