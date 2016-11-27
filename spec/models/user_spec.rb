require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.find(297789562, fetch: true) }

  it { is_expected.to be_valid }
  it { is_expected.to have_attributes(id: be_a(Fixnum), name: be_a(String))}

  describe "#tweets" do
    subject { User.find(297789562).tweets }

    it { is_expected.not_to be_empty }
    it { is_expected.to all(be_a(Tweet)) }
    it { is_expected.to all(have_attributes(id: be_a(Fixnum), text: be_a(String))) }
  end

  describe "#friends" do
    subject { User.find(297789562).friend_ids }

    it { is_expected.not_to be_empty }
    it { is_expected.to all(be_a(Fixnum)) }

    context "when a user has no friends" do
      # Created a fake empty array response
      subject { User.find(9999).friend_ids }

      it { is_expected.to be_empty }
    end
  end
end
