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

    LAYOUT_ATTRIBUTES.each do |name, layout_attribute|
      define_method(name) do
        constraint_with(layout_attribute)
      end
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

    private
    def constraint_with(layout_attribute)
      view_attribute = ViewAttribute.new(self.view, layout_attribute)
      constraint = ViewConstraint.new(view_attribute)
      self.constraints << constraint
      constraint
    end
  end
end