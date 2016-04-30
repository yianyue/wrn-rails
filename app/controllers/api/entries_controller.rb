class Api::EntriesController < ApplicationController

  before_action :authenticate_user

  def index
    @entries = current_user.entries.order(created_at: :desc)
    # @entries.where(word_count: 0).delete_all. NOTE: do not delete. need to track goals
    Entry.create(user: current_user) if @entries.empty? || @entries.first.created_at.to_date < Date.current
  end

  def show
    @entry = current_user.entries
    @entry = @entry.find(params[:id])
    render json: {error: 'This entry is locked.'}, status: :unauthorized if @entry.locked
  end

  def update
    # @entries = []
    @entry = Entry.find(params[:id])
    @entry.update(entry_params) if @entry.created_at.to_date == Date.current.in_time_zone
  end

  protected

  def entry_params
    params.require(:data).permit(:content)
  end

end
