require 'rails_helper'

describe Artist, type: :model do
  describe "relationships" do
    it { should have_many :pets}
  end
end
