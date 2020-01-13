# README
Though I have created the basic app structure to get some factories, the base code lies in lib/services/.

The base file which contains discrepancy calculation is:

  lib/services/campaign_discrepancy.rb,
  
  and the corresponding specs for the scenarios are included in:
 
  spec/lib/services/campaign_discrepancy_spec.rb

campaign_discrepancy.rb module uses the external service (lib/services/campaign_info.rb), to get campaigns from external JSON API.

To evaluate the service and calculation, just clone the repository and run the following commands:

 1.bundle install
 
 2.rails db:setup
 
 3.Run migration in test env
 
 4.bundle exec rspec
 
 Please check the code and specs and let me know if any further clarifications required.
 
 Mail me: anija.sarathomas43@gmail.com
