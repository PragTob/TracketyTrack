module StatisticsHelper

  NUMBER_OF_STEPS = 5
  WIDTH_OF_BARS = 30
  SPACING_BETWEEN_BARS = 15

  def generate_burndown_chart(completed_story_points_per_unit, initial_story_points, legend_label)
    story_points = [initial_story_points]
    legend_dates = ['initial']
    completed_story_points_per_unit.each do |date, story_points_of_unit|
      story_points << (story_points.last - story_points_of_unit)
      legend_dates << date
    end
    axis_scale = get_axis_scale(story_points.max)
    chart = Gchart.bar(
                data: story_points,
                axis_with_labels: ['x,y'],
                axis_labels: [legend_dates],
                max_value: axis_scale[1],
                axis_range: [nil, axis_scale],
                legend: legend_label,
                bar_width_and_spacing:
                  {width: WIDTH_OF_BARS,
                  spacing: SPACING_BETWEEN_BARS},
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

  def generate_burnup_chart(completed_story_points_per_unit, legend_label, all_story_points_per_unit)
    axis_scale = get_axis_scale(all_story_points_per_unit.values.max)
    chart = "http://chart.apis.google.com/chart?" +
      # general settings
      "chbh=" + WIDTH_OF_BARS.to_s + "," + SPACING_BETWEEN_BARS.to_s +
      "&cht=bvs&chxt=x,y&chs=1000x200" +
      "&chdl=" + legend_label +
      # data for bars of completed story points
      "&chd=t1:" + get_completed_story_points(completed_story_points_per_unit) +
      # data for line of all story points
      "|" + get_line_dates(all_story_points_per_unit) +
      "&chm=D,FF0000,1,0,2,1" +
      # label for axis
      "&chxl=0:|" + get_legend_dates(completed_story_points_per_unit) +
      "&chxr=1," + axis_scale*"," +
      "&chds=0," + axis_scale[1].to_s
    chart
  end

  def get_completed_story_points(completed_story_points_per_unit)
    completed_story_points = []
    completed_story_points_per_unit.each do |date, story_points_of_unit|
      if completed_story_points.empty?
        completed_story_points << story_points_of_unit
      else
        completed_story_points << (completed_story_points.last + story_points_of_unit)
      end
    end
    completed_story_points*","
  end

  def get_legend_dates(completed_story_points_per_unit)
    legend_dates = []
    completed_story_points_per_unit.each do |date, story_points_of_unit|
      legend_dates << date
    end
    legend_dates*"|"
  end

  def get_line_dates(all_story_points_per_unit)
    line_dates = []
    all_story_points_per_unit.each do |date, story_points_of_unit|
      line_dates << story_points_of_unit
    end
    line_dates*","
  end

end

