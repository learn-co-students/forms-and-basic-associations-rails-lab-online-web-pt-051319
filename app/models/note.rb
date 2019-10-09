class Note < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :songs
end
