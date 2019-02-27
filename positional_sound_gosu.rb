require "gosu"
require_relative "lib/listener"
require_relative "lib/source"

class Window < Gosu::Window
  def initialize
    super(720, 480, fullscreen: false, resizable: true)

    @listener = Listener.new(x: width/2, y: height/2)
  end

  def draw
    @listener.draw
  end

  def update
  end
end

Window.new.show