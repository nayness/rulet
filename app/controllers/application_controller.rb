class ApplicationController < ActionController::Base
  def random_color
    weighted_colors = [[1,2],[2,49],[3,49]]
    colors_probabilities = []
    weighted_colors.each do |color|
      color[1].times { colors_probabilities << color[0] }
    end
    colors_probabilities.sample
  end

end
