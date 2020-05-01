# Antipattern
class SongsController < ApplicationController
  def index
    @songs = Song.all
    respond_to do |format|
      format.html
      format.xml { render xml: @songs }
    end
  end

  def show
    @songs = Song.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render xml: @song }
    end
  end

  # etc ...
end



# solution
class SongsController < ApplicationController
  respond_to :html, :xml # <----

  def index
    @songs = Song.all
    respond_with(@songs)
  end

  def show
    @songs = Song.find(params[:id])
    respond_with(@song)
  end

  # etc ...
end
