class PagesController < ApplicationController
  before_action :check_for_login, :only => [:dashboard]
  layout :home_layout, :only => :index

  def index
    if @current_user.present? && @current_user.teams.present?
      redirect_to dashboard_path
    else
      render :landing
    end
  end

  def division
    @age_group = params[:age_group]
    @division = params[:division]
    div_matches = Match.age_group(@age_group).division(@division)
    one_round = Team.in_division(@age_group, @division).size/2 #number of games per round - dependent on num teams in div
    @fixtures = div_matches.fixtures.soonest_to_farthest.page(1).per(one_round)
    @results = div_matches.results.recent_to_oldest.page(1).per(one_round)
  end

  def division_results
    @age_group = params[:age_group]
    @division = params[:division]
    @page = params[:page]
    @results = Match.age_group(@age_group).division(@division).results.recent_to_oldest.page(@page)
  end

  def division_fixtures
    @age_group = params[:age_group]
    @division = params[:division]
    @page = params[:page]
    @fixtures = Match.age_group(@age_group).division(@division).fixtures.soonest_to_farthest.page(@page)
  end

  def age_group
    @age_group = params[:age_group]
    @teams = Team.in_age_group @age_group
    @divisions = @teams.pluck(:division).uniq.sort
  end

  def dashboard
      @favs = @current_user.favs
  end

  def navigator
    @teams = Team.ordered
    @clubs = @teams.map{|t| t.club.name}.uniq.sort
    @age_groups = @teams.pluck(:age_group).uniq.sort
    @divisions = @teams.pluck(:division).uniq.sort
  end

  def chart_test
    matches = Match.age_group('PL').division('1').results
    @data = StatsOverTime.new(matches).call(:gf)
  end

  private
  def home_layout
    @current_user.present? && @current_user.teams.present? ? 'application' : 'splash'
  end


end
