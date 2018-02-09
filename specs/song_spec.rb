require("minitest/autorun")
require_relative("../song")


class TestSong < MiniTest::Test

  def setup
    @song = Song.new("Like a Bird", "Nelly Furtado")
  end

  def test_song_has_name
    assert_equal("Like a Bird", @song.song_name())
  end

  def test_song_has_artist
    assert_equal("Nelly Furtado", @song.artist())
  end


end
