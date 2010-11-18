module LiquidFilter
  include ActionView::Helpers::TagHelper
  include ProjectsHelper

  def tasks_listing(tasks)
    output = <<-TABLE
     <div class='listing'>
      <table>
        <thead>
          <tr>
              <th>Name</th>
              <th>Description</th>
              <th>Owner</th>
              <th>Status</th>
              <th>Start Date</th>
              <th>End Date</th>
           </tr>
       </thead>
       <tbody>
    TABLE

    tasks.each do |task|
      output+="<tr><td>#{task.name}</td>"
      output+="<td>#{task.description}</td>"
      output+="<td>#{task.user.name}</td>"
      output+="<td>#{task.status}</td>"
      output+="<td>#{task.start_date}</td>"
      output+="<td>#{task.end_date}</td></tr>"
    end
    output +="</tbody></table></div>"
  end

  def draw_graph(file_name)
   #For Showing Ui i.e for html page
   output = ""
   output +="<img src='/display_image?file_name=#{file_name}'> </img>"
   #For Writing into pdf
    output+="<div class='filter-dont-show'>{{ project.draw_task_status_graph | draw_graph_in_pdf:project }}</div>"
  end


  def draw_graph_in_pdf(graph,project)
    filename = "#{project.name}#{Time.now.strftime('%s')}.png"
    file = Tempfile.new(filename)
    file = file.binmode
    file.write(graph)
    file.close
    content_tag(:img,'',:src=> file.path)
  end
  ##
#  def draw_status_graph(project)
#    graph = project.draw_task_status_graph
#    filename = "#{project.name}#{Time.now.strftime('%s')}.png"
#    file = Tempfile.new(filename)
#    file = file.binmode
#    file.write(graph)
#    file.close
#    content_tag(:img,'',:src=> file.path)
#  end

end
