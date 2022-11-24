class Post < ApplicationRecord
  validates :original_url, presence: true

  belongs_to :user
end
