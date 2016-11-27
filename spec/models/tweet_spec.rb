require 'rails_helper'

RSpec.describe Tweet, type: :model do
  subject { Tweet.find(791435354658131968, fetch: true) }

  it { is_expected.to be_valid }

  it { is_expected.to have_attributes(
    id: be_a(Fixnum),
    text: be_a(String),
    user: be_a(User)
  )}
end
