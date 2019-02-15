class CreditsController < ApplicationController

  def index
    @team = admin_team_fetch
    @members = @team.users
  end

  private

  def admin_team_fetch
    config = Rails.configuration.rsp
    if config["teamid"].is_a? Integer
      Team.find(config["teamid"])
    else
      throw 'Invalid config: config/rsp.yml'
    end
  end
end
