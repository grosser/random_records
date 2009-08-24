require File.expand_path("spec_helper", File.dirname(__FILE__))

describe :random do
  before :all do
    10.times {|i| User.create!}
  end

  it "finds a record when called without parameters" do
    User.random.class.should == User
  end

  it "finds a single random record" do
    User.random(1).size.should == 1
    User.random(1)[0].class.should == User
  end

  it "finds by offset from rand" do
    User.should_receive(:rand).with(User.count).and_return 3
    User.random(1).should == [User.find(4)]
  end

  it "finds using the given count option" do
    User.should_receive(:rand).with(3).and_return 2
    User.random(1,:count=>3).should == [User.find(3)]
  end

  it "finds the requested number" do
    User.random(9).uniq.size.should == 9
  end

  it "finds from offset" do
    users = User.random(9).map(&:id).sort
    users.should == (users.first..users.last).to_a
  end

  it "randomizes results" do
    users = User.random(9).map(&:id)
    users.sort.should_not == users
  end

  it "finds count records when requested >= count" do
    User.random(20).size.should == User.count
  end

  it "returns empty array if number is 0" do
    User.random(0).should == []
  end

  it "is chainable" do
    User.first_5.random(9).size.should == 5
    User.first_5.random(4).size.should == 4
  end

  describe "with cluster_size" do
    it "finds the right amount" do
      User.random(4, :cluster_size=>2).size.should == 4
    end

    it "finds in clusters" do
      User.stub!(:rand).with().and_return rand()
      User.stub!(:rand).with(User.count).and_return 2, 6
      users = User.random(4, :cluster_size=>2)
      users.map(&:id).sort.should == [3,4,7,8]
    end

    it "does not find duplicates" do
      pending
      User.should_receive(:rand).with(User.count).and_return 2, 2, 6
      users = User.random(4, :cluster_size=>2)
      users.map(&:id).should == [3,4,7,8]
    end

    it "finds when cluster overlaps results" do
      User.should_receive(:rand).with().and_return 1,2
      User.should_receive(:rand).with(User.count).and_return 2, 6
      users = User.random(3, :cluster_size=>2)
      users.map(&:id).should == [7,4,3]
    end

    it "finds when cluster is bigger than results" do
      User.should_receive(:rand).with(User.count).and_return 2
      users = User.random(1, :cluster_size=>2)
      users.map(&:id).should == [3]
    end

    it "finds max when results are smaller than available" do
      users = User.random(User.count+5, :cluster_size=>2)
      users.size == User.count
    end

    it "raises if cluster_size is 0" do
      lambda{User.random(1, :cluster_size=>0)}.should raise_error
    end
  end
end

describe 'when no records exist' do
  before :all do
    User.delete_all
  end

  it 'finds nil without parameters' do
    User.random.should == nil
  end

  it "finds 0 for all calls" do
    User.random(20).should == []
  end
end