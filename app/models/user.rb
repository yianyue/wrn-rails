class User < ActiveRecord::Base

  has_many :entries, dependent: :delete_all

  has_secure_password

  validates :email, :name, presence: true
  validates :goal, numericality: { only_integer: true, greater_than: 0 }
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A.+@.+\z/

  after_create :generate_token

  def generate_token
    loop do
      token = SecureRandom.uuid
      break self.token = token unless User.where(token: token).first
    end
    self.save!
  end

end
