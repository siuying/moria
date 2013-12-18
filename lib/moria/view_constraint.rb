module Moria
  # A constraint, created by a ConstraintBuilder.
  # A view constraint contains two view attribute.
  class ViewConstraint
    attr_accessor :first_view_attribute
    attr_accessor :second_view_attribute

    def initialize(view_attribute)
      @first_view_attribute = view_attribute
    end
  end
end