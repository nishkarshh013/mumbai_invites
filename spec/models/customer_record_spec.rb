# spec/models/customer_record_spec.rb
require "rails_helper"

RSpec.describe CustomerRecord, type: :model do
  describe ".from_json_line" do
    it "parses valid JSON line correctly" do
      line = '{"user_id": 1, "name": "Alice", "latitude": 19.0, "longitude": 72.8}'
      record = CustomerRecord.from_json_line(line)

      expect(record.user_id).to eq(1)
      expect(record.name).to eq("Alice")
      expect(record.latitude).to eq(19.0)
      expect(record.longitude).to eq(72.8)
    end

    it "raises error for invalid JSON" do
      line = '{"user_id": 1, "name": "Alice"}' # missing lat/lon
      expect { CustomerRecord.from_json_line(line) }.to raise_error(ArgumentError)
    end
  end
end
