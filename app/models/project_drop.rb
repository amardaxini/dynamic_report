class ProjectDrop < Liquid::Drop
  attr_accessor :project
  def initialize(project)
    @project =project
   end

  def name
    @project.name
  end

  def start_date
     @project.start_date
  end

  def end_date
    @project.start_date
  end

  def description
    @project.description
  end

  def draw_task_status_graph
    graph=@project.draw_pie_chart_for_completed_vs_pending_task
    graph.render_png_str(9)
  end
end
