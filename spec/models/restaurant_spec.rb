require 'spec_helper'

describe Restaurant, type: :model do
  let(:user) { FactoryGirl.build(:user) }
  let(:review_params) { { thoughts: 'So so', rating: 3 } }

  subject(:restaurant) { FactoryGirl.build(:restaurant) }

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

end
