module RoundCommons
  COLORS = { green: 2, red: 49, black: 49 }.freeze
  def color_hex(color)
    case color
    when 'green'
      '#28a745'
    when 'red'
      '#dc3545'
    when 'black'
      '#343a40'
    else
      '#E2E2E2'
    end
  end

  def random_color
    colors_probabilities = []
    COLORS.each do |color, weight|
      weight.times { colors_probabilities << color }
    end
    colors_probabilities.sample.to_s
  end
end