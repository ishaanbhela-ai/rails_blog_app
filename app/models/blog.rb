class Blog < ApplicationRecord
  has_many :comments, dependent: :destroy
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  validates :title, presence: true
  validates :body, presence: true
end
