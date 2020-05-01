# Antipattern
# If client is forced to parse response, to check whether response is successfull or failure

class SongsController < ApplicationController
  # other restful actions

  def create
    @song = Song.new(params[:song])
    respond_to do |format|
      if @song.save
        format.xml { render xml: @song, location: @song } # no error tag on success
      else
        format.xml { render xml: @song.errors } # error tag on falilure
      end
    end
  end
end



# solution
class SongsController < ApplicationController
  # other restful actions

  def create
    @song = Song.new(params[:song])
    respond_to do |format|
      if @song.save
        format.xml { render xml: @song,
                            status: :created, # client checks what is the status code
                            location: @song }
      else
        format.xml { render xml: @song.errors,
                            status: :unprocessable_entity } # client checks what is the status code
      end
    end
  end
end
