class Prototypes::PopularController < ApplicationController
  def index
    @prototypes = Prototype.prototypes_pager(col: 'likes_count', order: 'DESC', page_num: params[:page])
    render "prototypes/index"
  end
end
