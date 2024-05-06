
class Vector

    attr_accessor :x, :y
    def initialize(x, y)
        @x = x
        @y = y
    end

    def rotate(angle)
        rad = angle * Math::PI / 180
        Vector.new(
            @x * Math.cos(rad) - @y * Math.sin(rad),
            @x * Math.sin(rad) + @y * Math.cos(rad)
        ).to_i
    end

    def to_i
        Vector.new(@x.to_i, @y.to_i)
    end

    def +(other)
        Vector.new(@x + other.x, @y + other.y)
    end

    def -(other)
        Vector.new(@x - other.x, @y - other.y)
    end
end