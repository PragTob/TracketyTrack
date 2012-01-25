module StatisticsHelper

  NUMBER_OF_STEPS = 5

  def generate_burn_chart(bar_data, legend_data, legend_label)
    axis_scale = get_axis_scale(bar_data.max)
    chart = Gchart.bar(
                data: bar_data,
                axis_with_labels: ['x,y'],
                axis_labels: [legend_data],
                max_value: axis_scale[1],
                axis_range: [nil, axis_scale],
                legend: legend_label,
                bar_width_and_spacing: {width: 30, spacing: 15},
                width: 1000)
    chart
  end

  def get_axis_scale(initial)
    initial = 0 if initial < 0
    # make sure to always round up to next 10
    max_y_value = (initial + 4).round(-1)
    axis_scale = [0, max_y_value]
    steps = ((max_y_value).round(-1))/NUMBER_OF_STEPS
    axis_scale << steps
    axis_scale
  end

end

