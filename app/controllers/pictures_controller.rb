class PicturesController < ApplicationController
  #extend CarrierWave::Mount
  #mount_uploader :image, ImageUploader
  #skip_before_action :login_required, only: [:index, :new, :create]
  #後で消す
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      rendar :new
    else
      if @picture.save
        redirect_to pictures_path, notice: "作成しました！"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @poicture.destroy
    redirect_to pictures_path, notice:"削除しました"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private
  def picture_params
    params.require(:picture).permit(:image, :content, :user_id)
  end

  def set_blog
    @picture = Picture.find(params[:id])
  end
end
