# frozen_string_literal: true

module BattlesHelper
  def battle_type_span(battle_type_id)
    content_tag :span, Buckler::BATTLE_TYPES[battle_type_id]
  end

  def character_name(character_id)
    content_tag :span, Buckler::CHARACTERS[character_id]
  end

  def control_type(control_type_id)
    control_type = Buckler::CONTROL_TYPES[control_type_id]
    content_tag :span, control_type[0].upcase
  end

  def rival_score_span(diff)
    css_class = case diff
                when ..-1 then 'text-danger'
                when 1.. then 'text-success'
                else ''
                end
    content_tag(:span, format('%+d', diff), class: css_class)
  end

  def mr_variation_span(variation)
    css_class = case variation
                when ..-1 then 'text-danger'
                when 1.. then 'text-success'
                else ''
                end
    content_tag(:span, format('%+d', variation), class: css_class)
  end

  def round_result(round_id)
    round = Buckler::ROUNDS[round_id]
    content_tag :span, round, style: 'width: 20px', class: "badge px-0 text-center round-#{round.downcase}"
  end

  def battle_points_chart(data, frame:, width: '100%', height: '100%')
    div_data = {
      controller: 'battle-points-chart',
      battle_points_chart_frame_value: frame,
      battle_points_chart_data_value: data.to_json
    }
    content_tag(:div, style: "position: relative; width: #{width}; height: #{height};", data: div_data) do
      content_tag :canvas, '', data: { battle_points_chart_target: 'canvas' }
    end
  end

  def character_select(form, attribute, include_any: false, **)
    choises = Buckler::CHARACTERS.invert
    select_list(form, attribute, choises, include_any:, **)
  end

  def control_type_select(form, attribute, include_any: false, **)
    choises = Buckler::CONTROL_TYPES.keys.index_by { |k| t("buckler.control_type.#{k}").titlecase }
    select_list(form, attribute, choises, include_any:, **)
  end

  def battle_type_select(form, attribute, include_any: false, **)
    choises = Buckler::BATTLE_TYPES.keys.index_by { |k| t("buckler.battle_type.#{k}").titlecase }
    select_list(form, attribute, choises, include_any:, **)
  end

  private

  def select_list(form, attribute, choises, include_any: false, **)
    opts = {}
    opts[:include_blank] = t('helpers.select.any').titlecase if include_any
    form.select(
      attribute,
      choises,
      opts,
      **
    )
  end
end
