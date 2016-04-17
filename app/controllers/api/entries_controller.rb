class Api::EntriesController < ApplicationController

  before_action :authenticate_user

  def index
    @entries = current_user.entries.order(:created_at)
    # @entries.where(word_count: 0).delete_all. NOTE: do not delete. need to track word_counts
    Entry.create(user: current_user) if @entries.empty?
    # TODO: time zone
    @entries << Entry.create(user: current_user) if @entries.last.created_at.to_date < Date.today
  end

  def show
    @entry = current_user.entries
    @entry = @entry.find(params[:id])
    render json: {error: 'This entry is locked.'}, status: :unauthorized if @entry.locked
  end

  def update
    # @entries = []
    @entry = Entry.find(params[:id])
    @entry.update(entry_params) if @entry.created_at.to_date == Date.today
  end

  protected

  def entry_params
    params.require(:data).permit(:content)
  end

end
