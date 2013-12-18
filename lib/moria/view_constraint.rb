module Moria
  # A constraint, created by a ConstraintBuilder.
  # A view constraint contains two view attribute (view, attribute) and a relation (>=, == or <=).
  class ViewConstraint
    attr_accessor :first_view_attribute
    attr_accessor :second_view_attribute

    attr_accessor :priority
    attr_accessor :relation
    attr_accessor :multiplier
    attr_accessor :constant

    attr_accessor :installed_view
    attr_accessor :layout_constraint

    def initialize(view_attribute)
      self.first_view_attribute = view_attribute
      self.priority             = UILayoutPriorityRequired
      self.relation             = 0.0
      self.multiplier           = 1.0
      self.constant             = 0.0
    end

    # install constraint on view
    def install
      first_view              = first_view_attribute.view
      first_layout_attribute  = first_view_attribute.layout_attribute
      second_view             = second_view_attribute ? second_view_attribute.view : nil
      second_layout_attribute = second_view_attribute ? second_view_attribute.layout_attribute : 0

      if first_view_attribute.alignment_attribute? && second_view_attribute.nil?
        raise "alignment attributes must have a second_view_attribute: #{self}"
      end

      self.constant = second_view_attribute.constant if second_view_attribute && second_view_attribute.constant

      constraint = NSLayoutConstraint.constraintWithItem(first_view, attribute:first_layout_attribute, relatedBy:self.relation, 
          toItem:second_view, attribute: second_layout_attribute, multiplier:self.multiplier, constant: self.constant)
      constraint.priority = self.priority

      if second_view_attribute
        closest_common_superview = first_view.closest_common_superview(second_view)
        raise "Cannot install constraint: Could not find a common superview between #{first_view} and #{second_view}" unless closest_common_superview
        self.installed_view = closest_common_superview
      else
        self.installed_view = first_view
      end

      self.installed_view.addConstraint(constraint)
      self.layout_constraint = constraint
      self
    end

    def offset(constant)
      self.constant = constant
      self
    end

    def with
      self
    end

    def ==(another)
      # overrided == for the DSL
      if another.is_a?(ViewAttribute)
        self.second_view_attribute = another
        self.relation = NSLayoutRelationEqual
        return self
      end

      if another.is_a?(Numeric)
        self.constant = another
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

      if another.is_a?(Numeric)
        self.constant = another
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

      if another.is_a?(Numeric)
        self.constant = another
        self.relation = NSLayoutRelationLessThanOrEqual
        return self
      end

      super
    end
  end
end