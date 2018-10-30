# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :set_link, only: [:show]

  # GET /links/1
  # GET /links/1.json
  def show
    get_videos
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    @link = Link.find_by(youtube_id: @link.youtube_get_id) || @link

    respond_to do |format|
      if @link.save
        get_videos
        format.html { redirect_to @link, notice: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
        format.js { render template:  "links/show" }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
        format.js { render template:  "links/show" }
      end
    end
  end


  private

  def get_videos
    if @link.youtube_type.playlist?
      @video_list = ::Utilities::YoutubeDl.get_list(@link.url)
    else
      @video = ::Utilities::YoutubeDl.get_metadata(@link.url)
      @formats = @video.formats.group_by(&:type) if @video.present?
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find_by(slug: params[:id]) || Link.create_by(id: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def link_params
    params.require(:link).permit(:url)
  end
end
