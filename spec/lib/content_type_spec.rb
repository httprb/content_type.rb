# frozen_string_literal: true

RSpec.describe ContentType do
  subject(:content_type) { described_class.parse raw }

  describe ".parse" do
    context "application/json" do
      let(:raw) { "application/json" }

      its(:type)    { should eq "application" }
      its(:subtype) { should eq "json" }
      its(:charset) { should be_nil }
    end

    context "application/json; charset=utf-8" do
      let(:raw) { "application/json; charset=utf-8" }

      its(:type)    { should eq "application" }
      its(:subtype) { should eq "json" }
      its(:charset) { should eq "utf-8" }
    end

    context "x-dead/beef; any=thing" do
      let(:raw) { "x-dead/beef; any=thing" }

      its(:type)        { should eq "x-dead" }
      its(:subtype)     { should eq "beef" }
      its(:parameters)  { should eq "any" => "thing" }
    end

    context "application/vnd.oasis.opendocument.text" do
      let(:raw) { "application/vnd.oasis.opendocument.text" }

      its(:type)        { should eq "application" }
      its(:subtype)     { should eq "vnd.oasis.opendocument.text" }
    end

    context "vnd.android.cursor.dir/vnd.myexample.whatever" do
      let(:raw) { "vnd.android.cursor.dir/vnd.myexample.whatever" }

      its(:type)        { should eq "vnd.android.cursor.dir" }
      its(:subtype)     { should eq "vnd.myexample.whatever" }
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
