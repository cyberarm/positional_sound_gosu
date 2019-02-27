class AudioSource < GameObject
  attr_reader :sound, :channel
  attr_accessor :volume, :speed, :pan
  attr_accessor :follow
  def setup
    @channel = nil
    @sound = Gosu::Sample.new(@options[:sound])

    @volume= 1.0
    @speed = 1.0
    @pan   = 0.0

    @follow = nil
  end

  def draw
    Gosu.draw_rect(@x - @size/2, @y - @size/2, @size/2, @size/2, Gosu::Color.new(127, 63, 127))
  end

  def update
    @angle %= 359
    if @follow == :mouse
      @x, @y = $window.mouse_x + @size * 0.25, $window.mouse_y + @size * 0.25
    end

    if @channel
      @channel.volume = @volume
      @channel.speed  = @speed
      @channel.pan    = @pan
    end
  end

  def mouse_over?
    $window.mouse_x.between?(@x - @size/2, @x + @size/2) &&
    $window.mouse_y.between?(@y - @size/2, @y + @size/2)
  end

  def play
    @channel = @sound.play(@volume, @speed, true)
  end

  def playing?
    @channel && @sound.playing?
  end

  def stop
    @sound.stop
    @channel = nil
  end
end