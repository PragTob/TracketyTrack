module StatisticsHelper

  NUMBER_OF_STEPS = 5

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

  def generate_burnup_chart
    chart = "http://chart.apis.google.com/chart?" +
    "chxl=0:|0|1|2|4|5&chxt=x,y&chbh=30,15,8&cht=bvs&"+
    "chs=1000x200&chxr=1,0,180,20&" +
    "chd=t1:10,50,60,80,40|100,110,100,90,80&chds=0,180&" +
    "chm=D,FF0000,1,0,2,1"
    chart
  end

end

