class Entry < ActiveRecord::Base

  # attr_accessor :temp

  belongs_to :user
  
  before_create :set_default
  before_update :update_word_count_and_preview, if: :content_changed?  

  # private

  # def attributes
  #   super.merge('temp' => self.temp)
  # end

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

  def self.set_lock(entries)
    entries = entries.order(:created_at)
    entries.update_all(locked: false)

    total_days = Date.today - entries.first.created_at.to_date
    days_completed = entries.where("word_count >= goal").length
    num_lock = [entries.size - 1, total_days-days_completed].min

    if num_lock > 0
      (0...num_lock).each{ |i|
        entries[i].update_columns(locked: true)
      }
    end
    return entries
    # return [entries[num_lock-1], entries[num_lock]]
  end
  
end