module ApplicationHelper

  def hide_on_path(path)
    "hide" if !request.url.end_with?(path)
  end

  def winning_team
    instinct = User.where(team: 'instinct').count
    valor = User.where(team: 'valor').count
    mystic = User.where(team: 'mystic').count
    ranks = [
      {:name => 'instinct', :count => instinct},
      {:name => 'valor', :count => valor},
      {:name => 'mystic', :count => mystic}
    ]

    ranks.sort! { |a,b| b[:count] <=> a[:count] }
    ranks[0][:name]
  end

end
