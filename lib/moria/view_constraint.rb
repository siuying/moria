module Moria
  # A constraint, created by a ConstraintBuilder.
  # A view constraint contains two view attribute (view, attribute) and a relation (>=, == or <=).
  class ViewConstraint
    attr_accessor :first_view_attribute
    attr_accessor :second_view_attribute

    attr_accessor :layout_priority
    attr_accessor :layout_relation
    attr_accessor :layout_multiplier
    attr_accessor :layout_constant

    attr_accessor :installed_view
    attr_accessor :layout_constraint

    attr_accessor :moria_key

    def initialize(view_attribute)
      self.first_view_attribute = view_attribute
      self.layout_priority      = UILayoutPriorityRequired
      self.layout_relation      = 0.0
      self.layout_multiplier    = 1.0
      self.layout_constant      = 0.0
    end

    # build a NSLayoutConstraint using layout_priority, layout_relation, layout_multiplier, layout_constant, first view attribute and optionally second view attribute
    # and then install the constraint on view.
    def install
      first_view              = first_view_attribute.view
      first_layout_attribute  = first_view_attribute.layout_attribute
      second_view             = second_view_attribute.view if second_view_attribute
      second_layout_attribute = second_view_attribute ? second_view_attribute.layout_attribute : 0

      # alignment attributes must have a second_view_attribute
      # missing second_view_attribute assumed refer to superview
      # left == 10 is same as left == superview.left.offset(10)
      if first_view_attribute.alignment_attribute? && second_view.nil?
        second_view = first_view.superview
        second_layout_attribute = first_layout_attribute
      end

      self.layout_constant = second_view_attribute.constant if second_view_attribute && second_view_attribute.constant

      constraint = LayoutConstraint.constraintWithItem(first_view, attribute:first_layout_attribute, relatedBy:self.layout_relation, 
          toItem:second_view, attribute: second_layout_attribute, multiplier:self.layout_multiplier, constant: self.layout_constant)
      constraint.priority = self.layout_priority
      constraint.moria_key = self.moria_key

      if second_view
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

    # remove the constraint from view
    def uninstall
      self.installed_view.removeConstraint(self.layout_constraint)
      self.layout_constraint = nil
      self.installed_view = nil
    end

    def offset(constant)
      self.layout_constant = constant
      self
    end

    def with
      self
    end

    def priority(value)
      self.layout_priority = value
      self
    end

    def priority_high
      self.layout_priority = UILayoutPriorityDefaultHigh
      self
    end

    def priority_low
      self.layout_priority = UILayoutPriorityDefaultLow
      self
    end

    def key(key)
      self.moria_key = key
      self
    end

    def ==(another)
      # overrided == for the DSL
      if another.is_a?(ViewAttribute)
        self.second_view_attribute = another
        self.layout_relation = NSLayoutRelationEqual
        return self
      end

      if another.is_a?(Numeric)
        self.layout_constant = another
        self.layout_relation = NSLayoutRelationEqual
        return self
      end

      if another.is_a?(ViewConstraint)
        first_view_attribute == another.first_view_attribute && 
          second_view_attribute == another.second_view_attribute &&
          layout_relation == another.layout_relation
      else
        false
      end
    end

    def >=(another)
      # overrided == for the DSL
      if another.is_a?(ViewAttribute)
        self.second_view_attribute = another
        self.layout_relation = NSLayoutRelationGreaterThanOrEqual
        return self
      end

      if another.is_a?(Numeric)
        self.layout_constant = another
        self.layout_relation = NSLayoutRelationGreaterThanOrEqual
        return self
      end

      super
    end

    def <=(another)
      # overrided == for the DSL
      if another.is_a?(ViewAttribute)
        self.second_view_attribute = another
        self.layout_relation = NSLayoutRelationLessThanOrEqual
        return self
      end

      if another.is_a?(Numeric)
        self.layout_constant = another
        self.layout_relation = NSLayoutRelationLessThanOrEqual
        return self
      end

      super
    end
  end
end