class Project < ActiveRecord::Base
   
  has_many :tasks,:dependent => :destroy
  has_many :reports,:dependent => :destroy
  validates_presence_of :name
  validates_uniqueness_of :name
  #liquid_methods :name,:start_date,:description,:end_date

  def to_liquid
    ProjectDrop.new(self) 
  end

#  def to_liquid
#    {
#            'name'=>self.name,
#            'start_date'=>self.start_date,
#            'end_date'=>self.end_date,
#            'description'=>self.description,
#            'draw_pie_chart_for_completed_vs_pending_task'=>self.draw_pie_chart_for_completed_vs_pending_task
#    }
#  end


  def render_graph
    file_name = "#{Dir.tmpdir}/#{self.name}#{Time.now.strftime('%s')}.jpg"
    ch  = self.draw_pie_chart_for_completed_vs_pending_task
   # ch.render_png(file_name)
    ch.export_image(file_name)
    file_name
  end
  

  def draw_pie_chart_for_completed_vs_pending_task
    completed_count = self.tasks.by_status("Completed").count
    pending_count = self.tasks.by_status("Due").count

    r1 = Rdata.new
    r1.add_point([completed_count,pending_count],"Serie1")
    r1.add_point(["Completed","Pending"],"Serie2")
    r1.add_all_series
    r1.set_abscise_label_serie("Serie2")

    ch = Rchart.new(300,200)
    ch.set_font_properties("tahoma.ttf",8)
    ch.draw_filled_rounded_rectangle(7,7,293,193,5,240,240,240)
    ch.draw_rounded_rectangle(5,5,295,195,5,230,230,230)

    # Draw the pie chart
    ch.antialias_quality=0
    ch.set_shadow_properties(2,2,200,200,200)
    ch.draw_flat_pie_graph_with_shadow(r1.get_data,r1.get_data_description,120,100,60,Rchart::PIE_PERCENTAGE,8)
    ch.clear_shadow
    ch.draw_pie_legend(200,15,r1.get_data,r1.get_data_description,250,250,250)
    ch.draw_title(10,20,"Completed vs Pending",100,100,100)

    return ch
  end
end
