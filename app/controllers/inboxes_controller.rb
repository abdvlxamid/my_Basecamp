class InboxesController < ApplicationController
  before_action :set_project
  before_action :set_inbox, only: %i[ show edit update destroy ]

  # GET /inboxes or /inboxes.json
  def index
    @inboxes = @project.inboxes
  end

  # GET /inboxes/1 or /inboxes/1.json
  def show
    @messages = Message.where(inbox: @inbox)
    @message = @inbox.messages.build
  end

  
  # GET /inboxes/new
  def new
    @inbox = @project.inboxes.build
  end

  # GET /inboxes/1/edit
  def edit
  end

  # POST /inboxes or /inboxes.json
  def create
    @inbox = @project.inboxes.build(inbox_params)
    #@inbox = Inbox.new(inbox_params)

    respond_to do |format|
      if @inbox.save
        format.html { redirect_to project_inboxes_path(@project), notice: "Inbox was successfully created." }
        format.json { render :show, status: :created, location: @inbox }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inboxes/1 or /inboxes/1.json
  def update
    respond_to do |format|
      if @inbox.update(inbox_params)
        format.html { redirect_to [@project, @inbox], notice: "Inbox was successfully updated." }
        format.json { render :show, status: :ok, location: @inbox }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inboxes/1 or /inboxes/1.json
  def destroy
    @inbox.destroy

    respond_to do |format|
      format.html { redirect_to [@project, :inboxes], notice: "Inbox was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_inbox
      @inbox = @project.inboxes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inbox_params
      params.require(:inbox).permit(:name)
    end
end
