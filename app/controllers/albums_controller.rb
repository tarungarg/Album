class AlbumsController < ApplicationController

  def index
    @albums = current_user.albums
  end

  def show
    @album = current_user.albums.include_all.find(params[:id])
  end

  def new
    @album = current_user.albums.build
    1.times do
      @photos = @album.photos.build
      @photos.tags.build
    end
  end

  def create
    @album = current_user.albums.build(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to album_path(@album.id) }
      else
        format.html { redirect_to new_album_path, notice: @album.errors.full_messages.join('</br>').html_safe }
      end
    end
  end

  def destroy
    @album = current_user.albums.find(params[:id])
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url }
    end
  end

  def delete_image
    @album = current_user.albums.find(params[:album_id])
    photo = @album.photos.find(params[:id]) if @album
    photo.destroy
    redirect_to album_path(@album)
  end

end
