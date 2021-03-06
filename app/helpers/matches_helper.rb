module MatchesHelper

  #get other team in match
  def other_team match, this_team_id
    other = match.teams.select {|t| t != this_team_id}.first
    Team.find other
  end

  #time and date formatting
  def long_date_time time
    time.strftime('%l:%M%P, %A %B %e, %Y')
  end

  def short_date_time time
      time.strftime('%l:%M%P %a, %b %e')
  end

  def long_date time
    time.strftime('%A, %B %e, %Y')
  end

  def short_date time
    time.strftime('%a, %b %e')
  end

  def time_only time
    time.strftime('%l:%M%P')
  end

  def days_from_today(future_time)
    pluralize(((future_time - Time.now)/1.day).floor, 'day')
  end

end
