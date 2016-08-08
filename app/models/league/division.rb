require 'match_seeder/seeder'

class League
  class Division < ActiveRecord::Base
    include MatchSeeder

    belongs_to :league
    has_many :rosters, class_name: 'Roster'
    has_many :matches, -> { order(round: :desc, created_at: :asc) },
             through: :rosters, source: :home_team_matches, class_name: 'Match'

    validates :league, presence: true
    validates :name,   presence: true, length: { in: 1..64 }

    alias_attribute :to_s, :name

    def approved_rosters
      @approved_roster ||= rosters.where(approved: true)
    end

    def active_rosters
      approved_rosters.where(disbanded: false)
    end

    def rosters_sorted
      @rosters_sorted ||= approved_rosters.sort_by(&:sort_keys)
    end
  end
end