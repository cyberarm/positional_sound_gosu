class Listener < GameObject
  def setup
    @sources = []
    @size = 4
  end

  def draw

  end

  def update
    @sources.each do |source|
      next unless source.playing?

      localize_source(source)
    end
  end

  def add_source(source)
    @sources << source
  end

  def localize_source(source)

  end
end