# Antipattern

class Album < ActiveRecord::Base
  has_many :songs

class AlbumController < ApplicationController
  def show
    # ...
  end
end

# Song belongs to Album. but it does not have acces to album_id param, so must be i.e. passed as hidden field. Song is a lost child
class Song < ActiveRecord::Base
  belongs_to :album

class SongsController < ApplicationController
  def index
    # ...
  end
end

# config/routes.rb
resources :albums
resources :songs



# solution (gives album id available in param)
resources :albums do
  resources :songs
end

class SongsController < ApplicationController
  def index
    @songs = Album.find(params[:album_id])
    # ...
  end

  def show
    @song = @album.songs.find(params[:id])
  end

  # ...
end

# app/views/songs/_form.html.haml
= form_for([@album, @song]) do |f|
  # ...
