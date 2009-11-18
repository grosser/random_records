require 'active_record'

class ActiveRecord::Base
  def self.random(num=nil,options={})
    return_array = !num.nil?

    num ||= 1
    return [] if num == 0
    total = options.delete(:count) || count
    cluster_size = options.delete(:cluster_size) || num
    raise "Minimum :cluster_size is 1, got #{cluster_size}" if cluster_size < 1
    
    all = []
    num_clusters = (num.to_f / cluster_size).ceil
    num_clusters.times do
      all += random_clustered(cluster_size, total, options)
    end
    
    return_array ? all[0...num].sort{rand()} : all[0]
  end

  def self.random_clustered(num, total, options)
    highest_possible_offset = [0, total-num].max
    offset = [rand(total), highest_possible_offset].min
    limit = [num, total].min
    find(:all, {:offset => offset, :limit=>limit}.merge(options))
  end
end