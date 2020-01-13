require 'services/campaign_info'

module CampaignDiscrepancy
  # This class talks with External Campaign service which gives us campaign details
  class << self
    def calc_discrepency(ref_ids = [])
      discrepancy_res = []

      #iterate for each external ref_id and collect discrepancies
      ref_ids.each do |ref_id|
        internal_camp = Campaign.where(external_reference: ref_id).first
        json_res = CampaignInfo.fetch_data({date: Time.now})
        external_ref = json_res["ads"][0][ref_id]

        #create returning response hash with discrepancies
        status_hash = { "remote"=> external_ref[:status], "local"=> internal_camp.status} if internal_camp.status !=
                                                                                           external_ref[:status]
        description_hash = {"remote"=> external_ref[:description], "local"=> internal_camp.description} if internal_camp.description !=
                                                                                           external_ref[:description]
        discrepancy_ar  = []
        discrepancy_ar << {"status": status_hash} if status_hash.present?
        discrepancy_ar << {"description": description_hash} if description_hash.present?
        reference_res_hash = {"remote_reference": ref_id, "discrepancies": discrepancy_ar}
        discrepancy_res << reference_res_hash
      end
      return discrepancy_res
    end
  end
end