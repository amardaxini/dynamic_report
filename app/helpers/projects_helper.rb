require "tempfile"
module ProjectsHelper
  def draw_task_status_graph_for_pdf(project=Project.first)

   graph = project.draw_pie_chart_for_completed_vs_pending_task
   filename = "#{project.name}#{Time.now.strftime('%s')}.png"
   file = Tempfile.new(filename)
   file = file.binmode
   file.write(graph.render_png_str)
   file.close
   #content_tag(:div, file.path), :class => "graphs")
    #"<img src=#{file.path}></img>"
    content_tag(:img,'',:src=> file.path)
  end
end
