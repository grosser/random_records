class ActiveRecord::Base
  def self.random(num=nil,options={})
    return_array = !num.nil?
    num ||= 1
    return [] if num.zero?
    num_records = options.delete(:count) || count
    highest_possible_offset = [0,num_records-num].max 
    offset = [rand(num_records),highest_possible_offset].min
    limit = [num,num_records].min
    all = find(:all, {:offset => offset, :limit=>limit}.merge(options))
    return_array ? all : all[0]
  end
end