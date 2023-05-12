class AdGroupsController < ApplicationController
  before_action :set_context
  before_action :set_ad_group, only: %i[ show ]

  # GET /campaigns or /campaigns.json
  def index
    @ad_groups = @campaign.ad_groups
  end

  # GET /campaigns/1 or /campaigns/1.json
  def show
  end

  private

  def set_context
    @campaign = Campaign.find(params[:campaign_id])
  end


  def set_ad_group
    @ad_group = @campaign.ad_groups.find(params[:id])
  end
end
