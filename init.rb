class ActiveRecord::Base
  def self.random(num=1,options={})
    return [] if num.zero?
    num_records = options.delete(:count) || count
    highest_possible_offset = [0,num_records-num].max 
    offset = [rand(num_records),highest_possible_offset].min
    limit = [num,num_records].min
    find(:all, {:offset => offset, :limit=>limit}.merge(options))
  end
end