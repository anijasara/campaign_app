require "rails_helper"
require 'services/campaign_discrepancy.rb'

RSpec.describe "CampaignDiscrepancy" do
  describe '#calc_discrepency' do
    let(:campaign) {
      FactoryBot.create(:campaign, external_reference: "12", status: "active", description: "Ruby Engineer")
    }
    before(:each) do
      allow(CampaignInfo).to receive(:fetch_data).and_return({ "ads"=>["12" => {"status": "disabled", 
          "description": "Ruby On Rails Developer" }, 
          "16" => {"status": "active", "description": "AngularJS Developer" }]})
    end

    it "should give discrepancy response if there is difference in data" do      
      internal_campaign = campaign
      json_res = CampaignDiscrepancy.calc_discrepency(["12"])
      expect(json_res).to eq([{ :remote_reference=>"12",
                                :discrepancies=>[{:status=>{"remote"=>"disabled", "local"=>"active"}}, 
                                                 {:description=>{"remote"=>"Ruby On Rails Developer", 
                                                  "local"=>"Ruby Engineer"}}]
                              }])
    end

    it "should give null discrepancy response if remote and local data is same" do
      internal_campaign = FactoryBot.create(:campaign, external_reference: "16", status: "active", description: "AngularJS Developer")
      json_res = CampaignDiscrepancy.calc_discrepency(["16"])
      expect(json_res).to eq([{:remote_reference=>"16", :discrepancies=>[]}])
    end
  end
end