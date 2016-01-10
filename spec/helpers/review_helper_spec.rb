require 'rails_helper'

describe ReviewsHelper, type: :helper  do
  context '#star_rating' do
    it 'returns "N/A" if no ratings are given' do
      expect(helper.star_rating 'N/A').to eq 'N/A'
    end

    it 'returns five stars if 5 is given' do
      expect(helper.star_rating 5).to eq '★★★★★'
    end

    it 'returns two stars if 1.5 is given' do
      expect(helper.star_rating 1.5).to eq '★★☆☆☆'
    end
  end
end
