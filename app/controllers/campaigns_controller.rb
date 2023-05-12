class CampaignsController < ApplicationController
  before_action :set_campaign, only: %i[ show edit update destroy ]

  # GET /campaigns or /campaigns.json
  def index
    @campaigns = Campaign.all
  end

  # GET /campaigns/1 or /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns or /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to campaign_url(@campaign), notice: "Campaign was successfully created." }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1 or /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to campaign_url(@campaign), notice: "Campaign was successfully updated." }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1 or /campaigns/1.json
  def destroy
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: "Campaign was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    file = params[:file]
    xlsx = Roo::Excelx.new(file.path)
    xlsx.default_sheet = 'Sponsored Products Campaigns'
    header = xlsx.row(1)
    (2..xlsx.last_row).each do |i|
      row = Hash[[header, xlsx.row(i)].transpose]
      @campaign = Campaign.find_or_create_by(id: row['Campaign Id'], name: row['Campaign Name'], budget: row['Daily Budget']) if(row['Entity'].eql? 'Campaign')
      @ad_group = @campaign.ad_groups.find_or_create_by(id: row['Ad Group Id'], name: row['Ad Group Name'], default_bid: row['Ad Group Default Bid']) if(row['Entity'].eql? 'Ad Group')
      @ad_group.keywords.find_or_create_by(id: row['Keyword Id (Read only)'], text: row['Keyword Text'], bid: row['Bid'], match_type: row['Match Type'], impressions: row['Impressions'], clicks: row['Clicks'], ctr: row['Click-through Rate'],
                               spend: row['Spend'], sales: row['Sales'], orders: row['Orders'], units: row['Units'], cr: row['Coversion Rate'],
                               acos: row['ACOS'], cpc: row['CPC'], roas: row['ROAS']) if(row['Entity'].eql? 'Keyword')
    end
    redirect_to campaigns_path, notice: "Campaigns Imported Successfully"
  end

  def criteria_keywords
    @keywords = Keyword.includes(ad_group: :campaign)
                       .joins(:ad_group)
                       .where("ad_groups.name LIKE ?", "%NB%")
                       .where(spend: 1..Float::INFINITY, sales: 0)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campaign_params
      params.fetch(:campaign, {})
    end
end
