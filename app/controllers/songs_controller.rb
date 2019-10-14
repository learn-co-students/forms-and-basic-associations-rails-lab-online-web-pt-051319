require "pry"

class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    @genres = Genre.all
  end

  def create
  #  artist = Artist.find_or_create_by(name: params[:song][:artist_name])
    genre = Genre.find_by(id: params[:song][:genre_id])
  #  note1 = Note.find_or_create_by(content: params[:song_notes_1])
  #   note2 = Note.find_or_create_by(content: params[:song_notes_2])
    @song = Song.new(song_params)
    @song.genre = genre 
    @song.note_contents= ([params[:song_notes_1], params[:song_notes_2]])
    # @song = Song.new(song_params)
    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
  #  params[:song][:note_contents][] ||= []
    params.require(:song).permit(:title, :genre_name, :artist_name, :note_contents => [ :song_notes_1, :song_notes_2 ] )
  end
end

