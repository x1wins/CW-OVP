class EncodesController < ApplicationController
  before_action :set_encode, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /encodes
  # GET /encodes.json
  def index
    @encodes = Encode.all
  end

  # GET /encodes/1
  # GET /encodes/1.json
  def show
  end

  # GET /encodes/new
  def new
    @encode = Encode.new
  end

  # GET /encodes/1/edit
  def edit
  end

  # POST /encodes
  # POST /encodes.json
  def create
    @encode = Encode.new(encode_params)

    respond_to do |format|
      if @encode.save
        if @encode.file.attached?

          @encode.file.open do |f|
            temp_file_full_path = f.path
            Rails.logger.debug "temp file path : #{temp_file_full_path}"
            duration_output = `sh app/encoding/duration.sh #{temp_file_full_path}`
            Rails.logger.debug "ffmpeg parameter : #{File.basename(f.path)} #{temp_file_full_path}"
            file_path = "hls/#{File.basename(temp_file_full_path, ".*")}"
            file_full_path = "public/#{file_path}"
            encoding_output = `sh app/encoding/hls_h264.sh #{file_full_path} #{temp_file_full_path}`
            Rails.logger.debug "output : #{duration_output}"
            Rails.logger.debug "encoding_output : #{encoding_output}"
            Rails.logger.debug "full url : #{request.base_url}/#{file_path}/1080p.m3u8"
          end
          Rails.logger.debug "saved file path : #{rails_blob_path(@encode.file)}"
        end
        format.html { redirect_to @encode, notice: 'Encode was successfully created.' }
        format.json { render :show, status: :created, location: @encode }
      else
        format.html { render :new }
        format.json { render json: @encode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /encodes/1
  # PATCH/PUT /encodes/1.json
  def update
    respond_to do |format|
      if @encode.update(encode_params)
        format.html { redirect_to @encode, notice: 'Encode was successfully updated.' }
        format.json { render :show, status: :ok, location: @encode }
      else
        format.html { render :edit }
        format.json { render json: @encode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encodes/1
  # DELETE /encodes/1.json
  def destroy
    @encode.destroy
    respond_to do |format|
      format.html { redirect_to encodes_url, notice: 'Encode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encode
      @encode = Encode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def encode_params
      params.require(:encode).permit(:log, :started_at, :ended_at, :runtime, :completed, :user_id, :published, :file)
    end
end
