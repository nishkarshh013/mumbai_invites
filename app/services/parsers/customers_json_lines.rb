module Parsers
  class CustomersJsonLines
    include Enumerable

    def initialize(io)
      @io = io
    end

    def each
      return enum_for(:each) unless block_given?
      @io.each_line.with_index(1) do |line, idx|
        next if line.strip.empty?
        begin
          yield CustomerRecord.from_json_line(line)
        rescue ArgumentError => e
          Rails.logger.warn "Skipping invalid line ##{idx}: #{e.message}"
        end
      end
    end
  end
end
