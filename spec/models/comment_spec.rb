# frozen_string_literal: true

require 'rails_helper' # this
RSpec.describe Comment, type: :model do
  let(:user) { create(:user, email: 'email1@example.com') }
  let(:post) { create(:post) }

  subject do
    described_class.new(content: 'Anything',
                        post_id: post.id,
                        user_id: user.id)
  end

  describe 'valid attributes' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
    it { is_expected.to have_db_column(:content) }
    it { is_expected.to have_db_column(:post_id) }
    it { is_expected.to have_db_column(:user_id) }
  end

  describe 'Associations' do
    it { should belong_to(:user).without_validating_presence }
    it { should belong_to(:post).without_validating_presence }
  end
end
