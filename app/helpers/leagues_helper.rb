module LeaguesHelper
  include LeaguePermissions

    DISBAND_CONFIRM_MESSAGE = "Are you sure you want to disband rosters with more than 3 forfeit loses?\n"\
                              'This can not be undone automatically'.freeze

    UNDISBAND_CONFIRM_MESSAGE = "Are you sure you want to undisband ALL rosters in this season?\n"\
                                'This can not be undone automatically'.freeze
end
