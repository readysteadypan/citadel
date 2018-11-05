require 'auth/action_state'

module Auth
  class Ban < ActiveRecord::Base
    include ActionState

    validates :reason, presence: true, allow_blank: true

    validate :time_period

    scope :active, lambda {
      now = Time.zone.now
      where('terminated_at IS NULL OR (created_at < ? AND ? < terminated_at)', now, now)
    }

    def started_at
      self.created_at ||= Time.zone.now
    end

    def duration
      terminated_at - started_at
    end

    def duration=(value)
      self.terminated_at = started_at + value
    end

    def active?
      return true unless terminated_at

      now = Time.zone.now
      created_at < now && now < terminated_at
    end

    private

    def time_period
      return unless terminated_at

      errors.add(:terminated_at, 'Termination time must be after creation time') if terminated_at <= started_at
    end
  end
end
