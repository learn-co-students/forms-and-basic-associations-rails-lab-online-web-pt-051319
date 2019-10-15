class Song < ActiveRecord::Base
  belongs_to :genre
  belongs_to :artist
  has_many :notes

  def artist_name=(name_string)
    self.artist = Artist.find_or_create_by(name: name_string)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(contents)
    contents.each do |content|
      self.notes.build(content:content) unless content == "" 
    end
  end

  def note_contents
    self.notes.map do |note|
      note.content 
    end
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)  
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end



  
end