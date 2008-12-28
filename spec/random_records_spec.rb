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
    User.expects(:rand).with(User.count).returns 3
    User.random(1).should == [User.find(4)]
  end
  it "finds using the given count option" do
    User.expects(:rand).with(3).returns 2
    User.random(1,:count=>3).should == [User.find(3)]
  end
  it "finds the requested number" do
    User.random(9).uniq.size.should == 9
  end
  it "finds sequentially from offset" do
    users = User.random(9).map(&:id)
    users.each_with_index do |id,index|
      next if index.zero?
      id.should == (users[index-1] + 1)
    end
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
end

describe 'when no records exist' do
  before :all do
    User.delete_all
  end
  it 'finds nil without parameters' do
    User.random.should == nil
  end
  it "finds 0 for all calls" do
    User.random(20).size.should == 0
  end
end