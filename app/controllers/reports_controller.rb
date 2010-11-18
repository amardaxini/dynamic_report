
class ReportsController < ApplicationController
  acts_as_flying_saucer
  # GET /reports
  # GET /reports.xml
  include ProjectsHelper
  def index
    @projects = Project.all
    @report_templates = ReportTemplate.all
    @reports = Report.all
    @report = Report.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.xml
  def show
    @report = Report.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report }
    end
  end



  # POST /reports
  # POST /reports.xml
  def create


    @report = Report.new(params[:report])
    respond_to do |format|
      if @report.save
        format.html { redirect_to(@report, :notice => 'Report was successfully created.') }
        format.xml  { render :xml => @report, :status => :created, :location => @report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /reports/1
  # DELETE /reports/1.xml
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to(reports_url) }
      format.xml  { head :ok }
    end
  end
  def generate_pdf
    @report = Report.find(params[:id])
    arguments =   {"project"=>@report.project}
    @report_content =Liquid::Template.parse(@report.report_content).render(arguments,:filters => [LiquidFilter])
    respond_to do |format|
      format.pdf {
        render_pdf :template => 'reports/generate_pdf.pdf.erb',
                   :send_file => { :filename => "#{@report.report_name.to_s}.pdf"},
                   :debug_html =>params[:html_view]
      }
    end
  end
end
