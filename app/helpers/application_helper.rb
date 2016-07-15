module ApplicationHelper

  def hide_on_path(path)
    "hide" if !request.url.end_with?(path)
  end

end
