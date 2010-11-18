require 'liquid_filter'
class Report < ActiveRecord::Base
  belongs_to :report_template
  belongs_to :project
  before_save :update_content
  def update_content
    self.template_content = self.report_template.template_content #if self.template_content.blank?
    self.report_name = self.report_template.template_name
    arguments = {
            "project"=>self.project,
            "tasks"=>self.project.tasks,
            "pending_tasks"=>self.project.tasks.due_task,
            "completed_tasks"=>self.project.tasks.completed_task,
            "draw_task_status_graph"=>self.project.render_graph
    }

    content= self.template_content
    content = Liquid::Template.parse(content).render(arguments,:filters => [LiquidFilter])
    content = TidyFFI::Tidy.new(content, :show_body_only => 1,:output_xhtml=>1).clean
    content=content.gsub(/\n/,'')
    self.report_content = content
  end
end
