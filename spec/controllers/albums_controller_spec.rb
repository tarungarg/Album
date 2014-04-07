require 'spec_helper'

describe AlbumsController do
	render_views

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user_with_albums_photos_and_tags)
    sign_in @user
  end
	
	describe "Get index" do
    it "responds to GET" do
      get :index
      response.status.should eq(200)
    end

    it "should have body" do
      get :index
      response.body.should match /Listing Albums/
    end
  end

  describe "Get show" do
    it "responds to GET" do
    	id = @user.albums[0].id
      get :show, id: id
      response.status.should eq(200)
    end

    it "responds to GET" do
    	id = @user.albums[0].id
      get :show, id: id
      response.body.should match /Tags/
    end
  end

  describe "Get new" do
    it "responds to GET" do
      response.status.should eq(200)
    end
  end

  describe "Post Create" do
    before(:each) do
  	  media_image = Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images.jpg', 'image/jpg')
    	album = FactoryGirl.build(:album)
     	@params = {"album"=>{"name"=> album.name, "photos_attributes"=>{"0" => {"image"=> media_image, "tags_attributes" => { "0"=> {"caption"=>"#kn"}}}}}}
    end
    
    it "should responds to create" do
      before_count = Album.count
      post :create, @params
      after_count = Album.count
      before_count.should_not eq after_count
    end

    it "should redirect" do
      post :create, @params
      response.should redirect_to(Album.last)
    end
  end

  describe "Destroy Album" do
    before(:each) do
      @album_id = @user.albums[0].id
    end

    it "should destroys the album" do
      before_count = @user.albums.count
      delete :destroy, {id: @album_id}
      after_count = @user.albums.count
      before_count.should_not eq after_count
    end

    it "should redirect to index page" do
      delete :destroy, {id: @album_id}
      response.should redirect_to(albums_url)
    end
  end

  describe "Destroy Album's Image" do
    before(:each) do
      @photo_id = @user.albums.last.photos[0].id
      @album_id = @user.albums.last.id
    end

    it "should destroys the album's image" do
      before_count = @user.albums.last.photos.count
      delete :delete_image, {id: @photo_id, album_id: @album_id}
      after_count = @user.albums.last.photos.count
      before_count.should_not eq after_count
    end

  end
end
