class GameObject
  def initalize(x: 0, y: 0, z: 0, angle: 0, options: {})
    @x, @y, @z = x, y, z
    @angle = angle
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