class Api::EntriesController < ApplicationController

  before_action :authenticate_user

  def index
    @entries = current_user.entries.order(:created_at)
    @entries.where(word_count: 0).delete_all
    Entry.create(user: current_user) if @entries.empty?
    # TODO: time zone
    @entries << Entry.create(user: current_user) if @entries.last.created_at.to_date < Date.today
    @entries = Entry.set_lock(@entries)
    render json: @entries.as_json(only: [:id, :created_at, :preview, :word_count, :goal, :locked]), status: 200
  end

  def show
    @entry = current_user.entries    
    @entry = @entry.find(params[:id])
    if @entry && !@entry.locked
      render json: @entry
    else
      render json: {error: 'You are not authorized to access this entry.'}, status: 401
    end
  end

  def update
    # @entries = []
    @entry = Entry.find(params[:id])
    # if @entry.created_at.to_date == Date.today
      @entry.update(entry_params)
      @entries = Entry.set_lock(@entry.user.entries)
      @entries << @entry
      render json: @entries.as_json(only: [:id, :created_at, :preview, :word_count, :goal, :locked]), status: 200
    # else
    #   render json: @entry.as_json(only: [:id, :created_at, :preview, :word_count, :goal, :locked]), status: 401
    # end
  end

  protected
  
  def entry_params
    params.require(:entry).permit(:content)
  end

end
