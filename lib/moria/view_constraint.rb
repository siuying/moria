module Moria
  # A constraint, created by a ConstraintBuilder.
  # A view constraint contains two view attribute.
  class ViewConstraint
    attr_accessor :first_view_attribute
    attr_accessor :second_view_attribute
    attr_accessor :relation

    def initialize(view_attribute)
      self.first_view_attribute = view_attribute
    end
    
    def ==(another)
      # overrided == for the DSL
      if another.is_a?(ViewAttribute)
        self.second_view_attribute = another
        self.relation = NSLayoutRelationEqual
        return self
      end

      if another.is_a?(ViewConstraint)
        first_view_attribute == another.first_view_attribute && 
          second_view_attribute == another.second_view_attribute &&
          relation == another.relation
      else
        false
      end
    end

    def >=(another)
      # overrided == for the DSL
      if another.is_a?(ViewAttribute)
        self.second_view_attribute = another
        self.relation = NSLayoutRelationGreaterThanOrEqual
        return self
      end

      super
    end

    def <=(another)
      # overrided == for the DSL
      if another.is_a?(ViewAttribute)
        self.second_view_attribute = another
        self.relation = NSLayoutRelationLessThanOrEqual
        return self
      end

      super
    end
  end
end