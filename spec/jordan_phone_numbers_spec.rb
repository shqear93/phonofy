# frozen_string_literal: true

RSpec.describe "Jordan Phone Numbers" do
  # Test various Jordan phone number formats
  let(:jordan_mobile_zain) { "+962790123456" }    # Zain
  let(:jordan_mobile_orange) { "+962770123456" }  # Orange
  let(:jordan_mobile_umniah) { "+962780123456" }  # Umniah
  let(:jordan_landline) { "+96264123456" }        # Amman landline

  describe "Mobile numbers" do
    it "validates Zain numbers (79)" do
      phone = Phonelib.parse(jordan_mobile_zain)
      expect(phone.valid?).to be true
      expect(phone.valid_for_country?("JO")).to be true
      expect(phone.country).to eq("JO")
      expect(phone.type).to eq(:mobile)
    end

    it "validates Orange numbers (77)" do
      phone = Phonelib.parse(jordan_mobile_orange)
      expect(phone.valid?).to be true
      expect(phone.valid_for_country?("JO")).to be true
      expect(phone.country).to eq("JO")
      expect(phone.type).to eq(:mobile)
    end

    it "validates Umniah numbers (78)" do
      phone = Phonelib.parse(jordan_mobile_umniah)
      expect(phone.valid?).to be true
      expect(phone.valid_for_country?("JO")).to be true
      expect(phone.country).to eq("JO")
      expect(phone.type).to eq(:mobile)
    end

    it "formats mobile numbers correctly" do
      phone = Phonelib.parse(jordan_mobile_zain)
      expect(phone.e164).to eq("+962790123456")
      expect(phone.international).to eq("+962 7 9012 3456")
      expect(phone.national).to eq("07 9012 3456")
    end
  end

  describe "Landline numbers" do
    it "validates Amman landline numbers" do
      phone = Phonelib.parse(jordan_landline)
      expect(phone.valid_for_country?("JO")).to be true
      expect(phone.country).to eq("JO")
      expect([:fixed_line, :unknown]).to include(phone.type)
    end

    it "formats landline numbers correctly" do
      phone = Phonelib.parse(jordan_landline)
      expect(phone.e164).to eq("+96264123456")
      expect(phone.international).to be_a(String)
      expect(phone.national).to be_a(String)
    end
  end

  describe "Invalid numbers" do
    it "detects numbers with wrong country code" do
      # Lebanon country code with Jordan number format
      invalid_country = Phonelib.parse("+961790123456")
      expect(invalid_country.valid_for_country?("JO")).to be false
    end

    it "detects numbers that are too short" do
      too_short = Phonelib.parse("+9627901234")
      expect(too_short.valid?).to be false
    end

    it "detects numbers that are too long" do
      too_long = Phonelib.parse("+9627901234567890")
      expect(too_long.valid?).to be false
    end

    it "detects non-numeric characters" do
      non_numeric = Phonelib.parse("+962790ABC456")
      expect(non_numeric.valid?).to be false
    end
  end

  describe "Configuration for Jordan" do
    before(:each) do
      # Reset configuration before each test
      @original_config = Phonofy.configuration
      Phonofy.configuration = nil
    end

    after(:each) do
      # Restore original configuration after each test
      Phonofy.configuration = @original_config
    end

    it "allows setting Jordan as default country" do
      Phonofy.configure do |config|
        config.default_phonelib_options = { countries: [:jo] }
      end

      expect(Phonofy.config.default_phonelib_options).to eq({ countries: [:jo] })
    end

    it "allows setting multiple countries including Jordan" do
      Phonofy.configure do |config|
        config.default_phonelib_options = { countries: [:jo, :sa, :ae] }
      end

      expect(Phonofy.config.default_phonelib_options[:countries]).to include(:jo)
      expect(Phonofy.config.default_phonelib_options[:countries]).to include(:sa)
      expect(Phonofy.config.default_phonelib_options[:countries]).to include(:ae)
    end
  end
end
