class Entry < ActiveRecord::Base

  belongs_to :user

  before_create :set_default
  before_update :update_word_count_and_preview, if: :content_changed?

  def attributes
    super.merge( 'locked' => self.locked ) # why doesn't locked:self.locked work?
  end

  def locked
    entries = Entry.where(user: self.user).order(:created_at)
    total_days = entries.length
    days_completed = entries.where("word_count >= goal").length
    num_lock = [entries.size - 1, total_days - days_completed].min.to_i

    return self.created_at <= entries[num_lock-1].created_at

  end

  private

  def update_word_count_and_preview
    # update_columns skips callback and validation
    # otherwise it goes into a callback loop
    text_arr = self.content.gsub(/<.*?>/,' ').split
    text = text_arr[0...15].join(' ')
    text += ' ...' if text_arr.size > 15
    self.update_columns(word_count: text_arr.size)
    self.update_columns(preview: text)
  end

  def set_default
    # TODO: update_attributes
    self.goal = self.user.goal
    self.content = self.content || ''
    self.word_count = 0
    self.preview = ''
    # when seeding records, remember to update_word_count_and_preview
  end


end
