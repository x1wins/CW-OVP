require './lib/pagination'
require 'open3'

class EncodesController < ApplicationController
  before_action :set_encode, only: [:show, :destroy]
  before_action :authenticate_user!

  # GET /encodes
  # GET /encodes.json
  def index
    page = params[:page].presence || 1
    per = params[:per].presence || Pagination.per
    @encodes = Encode.with_attached_file.with_attached_thumbnails.published.by_date.page(page).per(per)
  end

  # GET /encodes/1
  # GET /encodes/1.json
  def show
  end

  # GET /encodes/new
  def new
    @encode = Encode.new
  end

  # POST /encodes
  # POST /encodes.json
  def create
    @encode = Encode.new(encode_params)
    respond_to do |format|
      if @encode.save
        Message::Send.call(Message::Event::CREATED, Message::Body.new(@encode, nil, nil, @encode.file.filename, nil))
        format.html { redirect_to @encode, notice: 'Encode was successfully created.' }
        format.json { render :show, status: :created, location: @encode }
      else
        format.html { render :new }
        format.json { render json: @encode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encodes/1
  # DELETE /encodes/1.json
  def destroy
    @encode.update(published: false)
    respond_to do |format|
      format.html { redirect_to encodes_url, notice: 'Encode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encode
      @encode = Encode.published.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def encode_params
      params.require(:encode).permit(:title, :file).merge(user_id: current_user.id)
    end
end
