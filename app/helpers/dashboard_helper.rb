module DashboardHelper
  # Returns a link for a table header that toggles sort direction and preserves the search query.
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, dashboard_path(sort: column, direction: direction, q: params[:q])
  end
end
