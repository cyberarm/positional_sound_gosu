require "gosu"
require_relative "lib/game_object"
require_relative "lib/listener"
require_relative "lib/audio_source"

class Window < Gosu::Window
  def initialize
    super(720, 480, fullscreen: false, resizable: true)
    $window = self

    @listener = Listener.new(x: width/2, y: height/2)
    @elements = [@listener]

    @font = Gosu::Font.new(18)

    add_source("sounds/song18_mono.ogg", width/2, height/2 - height/4)
    add_source("sounds/song18_mono.ogg", width/2, height/2 + height/4) # Stereo
  end

  def needs_cursor?
    true
  end

  def draw
    draw_rect(0, 0, width, height, Gosu::Color.new(31, 31, 31))
    @elements.each(&:draw)

    @listener.sources.each_with_index do |source, index|
      @font.draw_text(
        "#{source.class}[#{index}] volume: #{(source.volume * 100).round(2)}% pan: #{source.pan.round(2)} speed: #{source.speed}",
        10, 10 + (@font.height * index), 1)
    end
  end

  def update
    @elements.each(&:update)
  end

  def button_down(id)
    if id == Gosu::MsLeft
      @listener.sources.each do |source|
        if source.mouse_over?
          source.follow = :mouse
        end
      end
    end
  end

  def button_up(id)
    if id == Gosu::MsLeft
      @listener.sources.each do |source|
        if source.follow == :mouse
          source.follow = nil
        end
      end
    end
  end

  def add_source(sound, x, y)
    source = AudioSource.new(x: x, y: y, options: {sound: sound})
    @listener.add_source(source)
    @elements << source
  end

    # Sourced from https://gist.github.com/ippa/662583
  def draw_circle(cx,cy,r, z = 9999,color = Gosu::Color::GREEN, step = 10)
    0.step(360, step) do |a1|
      a2 = a1 + step
      draw_line(cx + Gosu.offset_x(a1, r), cy + Gosu.offset_y(a1, r), color, cx + Gosu.offset_x(a2, r), cy + Gosu.offset_y(a2, r), color, z)
    end
  end
end

Window.new.show