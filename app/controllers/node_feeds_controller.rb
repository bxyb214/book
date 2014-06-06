class NodeFeedsController < ApplicationController
  before_action :set_node_feed, only: [:show, :edit, :update, :destroy]

  # GET /node_feeds
  # GET /node_feeds.json
  def index
    @node_feeds = NodeFeed.all
  end

  # GET /node_feeds/1
  # GET /node_feeds/1.json
  def show
  end

  # GET /node_feeds/new
  def new
    @node_feed = NodeFeed.new
  end

  # GET /node_feeds/1/edit
  def edit
  end

  # POST /node_feeds
  # POST /node_feeds.json
  def create
    @node_feed = NodeFeed.new(node_feed_params)

    respond_to do |format|
      if @node_feed.save
        format.html { redirect_to @node_feed, notice: 'Node feed was successfully created.' }
        format.json { render action: 'show', status: :created, location: @node_feed }
      else
        format.html { render action: 'new' }
        format.json { render json: @node_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /node_feeds/1
  # PATCH/PUT /node_feeds/1.json
  def update
    respond_to do |format|
      if @node_feed.update(node_feed_params)
        format.html { redirect_to @node_feed, notice: 'Node feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @node_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_feeds/1
  # DELETE /node_feeds/1.json
  def destroy
    @node_feed.destroy
    respond_to do |format|
      format.html { redirect_to node_feeds_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node_feed
      @node_feed = NodeFeed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_feed_params
      params[:node_feed]
    end
end
