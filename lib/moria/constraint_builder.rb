module Moria
  class ConstraintBuilder
    attr_reader :view
    attr_accessor :constraints

    def initialize(view)
      @view = view
      @constraints = []
    end

    # install the constraints to view, the return the constraints object
    def install
      constraints = self.constraints.copy
      self.constraints.each do |constraint|
        constraint.install
      end
      self.constraints.clear
      constraints
    end

    # For each of the LAYOUT_ATTRIBUTES, create a method that ViewConstraint
    LAYOUT_ATTRIBUTES.each do |name, layout_attribute|
      define_method(name) do
        constraint_with(layout_attribute)
      end
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