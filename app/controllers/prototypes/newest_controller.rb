class Prototypes::NewestController < ApplicationController
  def index
    @prototypes = Prototype.prototypes_pager(col: 'created_at', order: 'DESC', page_num: params[:page])
    render "prototypes/index"
  end
end
