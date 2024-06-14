# frozen_string_literal: true

class PlayersController
  class BattlesAction < BaseAction
    attr_accessor :player_sid, :page

    attribute :player_character, :integer
    attribute :player_control_type, :integer
    attribute :opponent_character, :integer
    attribute :opponent_control_type, :integer
    attribute :battle_type, :integer
    attribute :played_from, :date, default: 7.days.ago
    attribute :played_to, :date, default: Time.zone.now

    def battles
      @battles ||= all_battles.order(played_at: :desc).page(page)
    end

    def rivals
      @rivals ||= all_battles.rivals.limit(5)
    end

    private

    def all_battles
      @all_battles ||= Battle.pov.where(
        {
          played_at:,
          battle_type:,
          player: player_criteria,
          opponent: opponent_criteria
        }.compact_blank
      )
    end

    def player_criteria
      {
        player_sid:,
        character: player_character,
        control_type: player_control_type
      }.compact_blank
    end

    def opponent_criteria
      {
        character: opponent_character,
        control_type: opponent_control_type
      }.compact_blank
    end

    def played_at
      from = played_from.try(:beginning_of_day)
      to = played_to.try(:end_of_day)
      return if [from, to].all?(:nil?)

      from..to
    end
  end
end
