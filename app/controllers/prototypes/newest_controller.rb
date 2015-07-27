class Prototypes::NewestController < ApplicationController
  def index
    @prototypes = Prototype.order('created_at DESC').page(params[:page]).per(3)
    render "prototypes/index"
  end
end
