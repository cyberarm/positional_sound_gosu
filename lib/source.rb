class AudioSource < GameObject
  def setup
    @channel = nil
    @sound = Gosu::Sound.new(@options[:sound])
  end

  def play
    @channel = @sound.play
  end

  def stop
    @sound.stop
  end
end