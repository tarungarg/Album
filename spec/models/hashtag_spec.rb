require 'spec_helper'

describe Hashtag do

  it { should allow_mass_assignment_of(:name) }
  it { should have_and_belong_to_many(:photos) }
end
