class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review review_params, user
    review = reviews.new(review_params)
    review.user = user
    review
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end
end
