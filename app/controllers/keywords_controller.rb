class KeywordsController < ApplicationController
  before_action :set_context
  before_action :set_keyword, only: %i[ show ]

  def index
    @keywords = @ad_group.keywords
  end

  def show
  end

  private

  def set_context
    @campaign = Campaign.find(params[:campaign_id])
    @ad_group = @campaign.ad_groups.find(params[:ad_group_id])
  end

  def set_keyword 
    @keyword = @ad_group.keywords.find(params[:id])
  end
end
