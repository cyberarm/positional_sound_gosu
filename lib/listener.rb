class Listener < GameObject
  attr_reader :sources
  def setup
    @range   = 225
    @sources = []
  end

  def draw
    Gosu.rotate(@angle, @x - (@size * 0.25), @y - (@size * 0.25)) do
      Gosu.draw_rect(@x - @size/2, @y - @size/2, @size/2, @size/2, Gosu::Color.new(255, 127, 0))
      Gosu.draw_rect(@x - (@size * 0.25), @y - @size/2, 1, -6, Gosu::Color::RED)
    end

    $window.draw_circle(@x, @y, @range, 0, Gosu::Color.new(0, 63, 127))
  end

  def update
    @angle -= 1 if Gosu.button_down?(Gosu::KbLeft)
    @angle += 1 if Gosu.button_down?(Gosu::KbRight)
    @angle %= 359

    @sources.each do |source|
      # next unless source.playing?

      localize_source(source)
    end
  end

  def add_source(source)
    @sources << source
    source.play
  end

  def localize_source(source)
    dist = Gosu.distance(@x, @y, source.x, source.y)
    if dist <= @range
      volume = ((dist/@range.to_f) - 1).abs
      source.volume = volume

      a = Gosu.angle(@x, @y, source.x, source.y)
      _angle = (((a - @angle) + 90) % 359).round(2) # Make an arc from left 0 to right 180 for front

      source.pan = rand(-10.0..10.0)
      if _angle.between?(0, 180) # source is in front of listener
        if _angle <= 90
          pan = (((-_angle / 90.to_f) + 1) * -1) * 0.00000005
          source.pan =  pan
        else
          pan = (((-_angle / 90.to_f) + 1) * -1) * 0.00000005
          source.pan =  pan
        end
      else # source is behind listener
        # tweak speed to make it 'feel' behind?
        _angle -= 180
        if _angle <= 90
          pan = ((-_angle / 90.to_f) + 1) * 0.00000005
          source.pan =  pan
        else
          pan = ((-_angle / 90.to_f) + 1) * 0.00000005
          source.pan =  pan
        end
      end

    else # Out of range
      source.volume = 0
    end
  end
end