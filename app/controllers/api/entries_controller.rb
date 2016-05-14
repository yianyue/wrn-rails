class Api::EntriesController < ApplicationController

  before_action :authenticate_user

  def index

    page = params[:page] || 1;
    @entries = current_user.entries.order(created_at: :desc).page(page).per(2)
    # @entries.where(word_count: 0).delete_all. NOTE: do not delete. need to track goals
    Entry.create(user: current_user) if page.to_i === 1 &&  (@entries.empty? || @entries.first.created_at.to_date < Date.current)
  end

  def show
    @entry = current_user.entries
    @entry = @entry.find(params[:id])
    render json: {error: 'This entry is locked.'}, status: :unauthorized if @entry.locked
  end

  def update
    # @entries = []
    @entry = current_user.entries
    @entry = @entry.find(params[:id])
    if @entry.created_at.to_date === Date.current
      @entry.update(entry_params)
    else
      render json:{ error: 'The day is over.'}, status: :unauthorized
    end
  end

  protected

  def entry_params
    params.require(:data).permit(:content)
  end

end
