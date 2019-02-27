class GameObject
  attr_accessor :x, :y, :z, :angle, :size
  attr_reader   :options
  def initialize(x: 0, y: 0, z: 0, angle: 0, size: 32, options: {})
    @x, @y, @z = x, y, z
    @angle = angle
    @size  = size
    @options = options

    setup
  end

  def setup
  end

  def draw
  end

  def update
  end
end