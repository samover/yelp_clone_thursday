require 'spec_helper'

describe Restaurant, type: :model do
  let(:user) { build(:user) }
  let(:user2) { build(:user2) }
  let(:review_params) { { thoughts: 'So so', rating: 3 } }
  let(:review_params2) { { thoughts: 'Bad', rating: 1 } }

  subject(:restaurant) { build(:restaurant) }

  it { is_expected.to have_many :reviews }

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: 'Five Guys')
    restaurant = Restaurant.new(name: 'Five Guys')
    expect(restaurant).to have(1).error_on :name
  end

  it 'can not have more than one review by the same user' do
    review1 = restaurant.build_review(review_params, user)
    review1.save
    review2 = restaurant.build_review(review_params, user)
    expect(review2.save).to eq false
  end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context '1 review' do
      it 'returns that rating' do
        restaurant.save
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
    end

    context '2 reviews' do
      it 'returns that rating' do
        restaurant.build_review(review_params, user)
        restaurant.save
        restaurant.build_review(review_params2, user2)
        restaurant.save
        expect(restaurant.average_rating).to eq 2
      end
    end
  end
end
