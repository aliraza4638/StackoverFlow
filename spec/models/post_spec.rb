# frozen_string_literal: true

require 'rails_helper'  # this
RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  subject do
    described_class.new(title: 'Anything',
                        description: 'Lorem ipsum',
                        user_id: user.id)
  end
  describe 'valid attributes' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
    it { is_expected.to have_db_column(:title) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:user_id) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it do
      post = FactoryBot.create(:post)
      expect(post.title).to eq('Post A')
      expect(post.description).to eq('Description of Post A')
    end
  end

  describe 'Associations' do
    it { should belong_to(:user).without_validating_presence }
  end
end
