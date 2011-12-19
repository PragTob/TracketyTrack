class SprintsController < ApplicationController

  before_filter :authenticate

  # GET /sprints
  # GET /sprints.json
  def index
    @sprints = Sprint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sprints }
    end
  end

  # GET /sprints/1
  # GET /sprints/1.json
  def show
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sprint }
    end
  end

  # GET /sprints/new
  # GET /sprints/new.json
  def new
    @sprint = Sprint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sprint }
    end
  end

  # GET /sprints/1/edit
  def edit
    @sprint = Sprint.find(params[:id])
  end

  # POST /sprints
  # POST /sprints.json
  def create
    @sprint = Sprint.new(params[:sprint])

    if @sprint.start_date.nil?
      @sprint.start_date = DateTime.now
      @sprint.end_date = DateTime.now
    end
    respond_to do |format|
      if @sprint.save
        if Sprint.actual_sprint == @sprint
          self.current_sprint = @sprint
        end
        format.html { redirect_to @sprint, flash: {success: 'Sprint was successfully created.'} }
        format.json { render json: @sprint, status: :created, location: @sprint }
      else
        format.html { render action: "new" }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sprints/1
  # PUT /sprints/1.json
  def update
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        format.html { redirect_to @sprint, flash: {success: 'Sprint was successfully updated.'} }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sprints/1
  # DELETE /sprints/1.json
  def destroy
    @sprint = Sprint.find(params[:id])
    @sprint.destroy

    respond_to do |format|
      format.html { redirect_to sprints_url }
      format.json { head :ok }
    end
  end

  # PUT /sprints/start
#  def start

#    if Sprint.actual_sprint?
#      self.current_sprint = Sprint.actual_sprint
#      respond_to do |format|
#        format.html { redirect_to sprint_planning_path, flash:
#                      {success: "Sprint #{current_sprint.number} was started." +
#                      "It is planned to end #{current_sprint.end_date}"} }
#      end
#    else
#      respond_to do |format|
#        format.html { redirect_to new_sprint_url }
#        format.json { head :ok }
#      end
#    end

#  end

  # PUT /sprints/stop/1
  def stop
    current_sprint.end_date = DateTime.now
    current_sprint.save

    self.current_sprint = nil

    respond_to do |format|
      format.html { redirect_to sprint_planning_path }
      format.json { head :ok }
    end

  end

end

