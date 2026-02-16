class Comment < ApplicationRecord
  belongs_to :blog

  validates :body, presence: true
  validate :blog_must_be_published

  private

  def blog_must_be_published
    errors.add(:blog, "must be published") unless blog&.published?
  end
end
