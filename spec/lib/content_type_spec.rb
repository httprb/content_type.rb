# frozen_string_literal: true

RSpec.describe ContentType do
  subject(:content_type) { described_class.parse raw }

  describe ".parse" do
    context "with ‹application/json›" do
      let(:raw) { "application/json" }

      its(:type)    { is_expected.to eq "application" }
      its(:subtype) { is_expected.to eq "json" }
      its(:charset) { is_expected.to be_nil }
    end

    context "with ‹application/json; charset=utf-8›" do
      let(:raw) { "application/json; charset=utf-8" }

      its(:type)    { is_expected.to eq "application" }
      its(:subtype) { is_expected.to eq "json" }
      its(:charset) { is_expected.to eq "utf-8" }
    end

    context "with ‹x-dead/beef; any=thing›" do
      let(:raw) { "x-dead/beef; any=thing" }

      its(:type)        { is_expected.to eq "x-dead" }
      its(:subtype)     { is_expected.to eq "beef" }
      its(:parameters)  { is_expected.to eq "any" => "thing" }
    end

    context "with ‹application/vnd.oasis.opendocument.text›" do
      let(:raw) { "application/vnd.oasis.opendocument.text" }

      its(:type)        { is_expected.to eq "application" }
      its(:subtype)     { is_expected.to eq "vnd.oasis.opendocument.text" }
    end

    context "with ‹vnd.android.cursor.dir/vnd.myexample.whatever›" do
      let(:raw) { "vnd.android.cursor.dir/vnd.myexample.whatever" }

      its(:type)        { is_expected.to eq "vnd.android.cursor.dir" }
      its(:subtype)     { is_expected.to eq "vnd.myexample.whatever" }
    end
  end

  describe "#type" do
    let(:raw) { "APPLICATION/jSOn" }

    it "is downcased" do
      expect(content_type.type).to eq "application"
    end
  end

  describe "#subtype" do
    let(:raw) { "APPLICATION/jSOn" }

    it "is downcased" do
      expect(content_type.subtype).to eq "json"
    end
  end

  describe "#parameters keys" do
    let(:raw) { "APPLICATION/jSOn; CHARset=utf-8" }

    it "are downcased" do
      expect(content_type.parameters).to include "charset"
    end
  end
end
