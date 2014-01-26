# coding: utf-8


require "spec_helper"


describe ContentType do
  subject(:content_type) { ContentType.parse raw }

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
