class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  has_one_attached :image

  def attributes
    {
      'id' => nil,
      'private' => nil,
      'content' => nil,
      'updated_at' => nil,
      'created_at' => nil,
      'image_url' => nil
    }
  end

  def image_url
    Rails.application.routes.url_helpers.rails_representation_url(
      image.variant(resize_to_limit: [200, 200]).processed, only_path: true
    )
  end
end
