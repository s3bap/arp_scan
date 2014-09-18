module ARPScan

  # This class abstracts the string output from arp-scan into an Object. A
  # ScanReports are usually created through the ScanResultProcessor module.
  #
  class ScanReport

    attr_reader :hosts, :interface, :datalink, :version, :range_size, :scan_time, :scan_rate, :reply_count

    # Create a new scan report, passing in every attribute. The best way to do
    # this is with the ScanResultProcessor module.
    #
    def initialize(hash)
      @hosts = hash[:hosts]
      @interface = hash[:interface]
      @datalink = hash[:datalink]
      @version = hash[:version]
      @range_size = Integer(hash[:range_size])
      @scan_time = Float(hash[:scan_time])
      @scan_rate = Float(hash[:scan_rate])
      @reply_count = Integer(hash[:reply_count])
    end

    # Returns an array representation of the ScanReport. Metadata about the
    # scan, and an array of Host arrays comprise the array.
    #
    def to_array
      self.instance_variables.map do |var|
        if var == :@hosts
          self.instance_variable_get(var).map {|host| host.to_array}
        else
          self.instance_variable_get(var)
        end
      end
    end

    # Returns a hash representation of the ScanReport. Metadata about the scan,
    # and array of Host hashes comprise the hash.
    #
    def to_hash
      { :hosts => @hosts.map {|host| host.to_hash},
        :interface => @interface,
        :datalink => @datalink,
        :version => @version,
        :range_size => @range_size,
        :scan_time => @scan_time,
        :scan_rate => @scan_rate,
        :reply_count => @reply_count
      }
    end

  end
end
