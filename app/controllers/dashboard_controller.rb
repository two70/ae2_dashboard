class DashboardController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @q = params[:q].to_s.strip
    @items = Item.all

    if @q.present?
      @items = @items.where("display_name LIKE ? OR CAST(amount AS TEXT) LIKE ?", "%#{@q}%", "%#{@q}%")
    end

    @items = @items.order("#{sort_column} #{sort_direction}")
    render :index
  end

  private

  def sort_column
    %w[display_name amount].include?(params[:sort]) ? params[:sort] : "display_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
