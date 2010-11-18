class ReportTemplatesController < ApplicationController
  # GET /report_templates
  # GET /report_templates.xml
  def index
    @report_templates = ReportTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @report_templates }
    end
  end

  # GET /report_templates/1
  # GET /report_templates/1.xml
  def show
    @report_template = ReportTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report_template }
    end
  end

  # GET /report_templates/new
  # GET /report_templates/new.xml
  def new
    @report_template = ReportTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report_template }
    end
  end

  # GET /report_templates/1/edit
  def edit
    @report_template = ReportTemplate.find(params[:id])
  end

  # POST /report_templates
  # POST /report_templates.xml
  def create
    @report_template = ReportTemplate.new(params[:report_template])

    respond_to do |format|
      if @report_template.save
        format.html { redirect_to(@report_template, :notice => 'Report template was successfully created.') }
        format.xml  { render :xml => @report_template, :status => :created, :location => @report_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /report_templates/1
  # PUT /report_templates/1.xml
  def update
    @report_template = ReportTemplate.find(params[:id])

    respond_to do |format|
      if @report_template.update_attributes(params[:report_template])
        format.html { redirect_to(@report_template, :notice => 'Report template was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /report_templates/1
  # DELETE /report_templates/1.xml
  def destroy
    @report_template = ReportTemplate.find(params[:id])
    @report_template.destroy

    respond_to do |format|
      format.html { redirect_to(report_templates_url) }
      format.xml  { head :ok }
    end
  end
end
