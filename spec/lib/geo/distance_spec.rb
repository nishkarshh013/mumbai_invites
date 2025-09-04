require "rails_helper"

RSpec.describe Geo::Distance do
  describe ".to_radians" do
    it "converts degrees to radians" do
      expect(described_class.to_radians(180)).to be_within(1e-10).of(Math::PI)
    end
  end

  describe ".between" do
    it "computes zero distance for identical points" do
      d = described_class.between(19.0, 72.0, 19.0, 72.0)
      expect(d).to be_within(1e-6).of(0.0)
    end

    it "computes known distance (Mumbai office to CST ~13.5 km)" do
      office_lat, office_lon = 19.0590317, 72.7553452
      cst_lat, cst_lon = 19.0760, 72.8777

      d = described_class.between(office_lat, office_lon, cst_lat, cst_lon)

      expect(d).to be_within(1.0).of(13.5) # allow ~1 km margin
    end
  end
end
