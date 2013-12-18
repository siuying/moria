module Moria
  class ConstraintBuilder
    attr_reader :view
    attr_reader :constraints

    def initialize(view)
      @view = view
      @constraints = []
    end

    def install
      true
    end

    def top
      self
    end

    def left
      self
    end

    def right
      self
    end

    def bottom
      self
    end

    def ==(constraint)
      self
    end

    def >=(constraint)
      self
    end

    def <=(constraint)
      self
    end

    def superview
      view.superview
    end
  end
end