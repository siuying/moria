module Moria
  module LayoutAttributeExtension
    LAYOUT_ATTRIBUTES.each do |key, value|
      define_method(key) do
        ViewAttribute.new self, value
      end
    end
  end

  module LayoutExtension
    def layout(&block)
      self.translatesAutoresizingMaskIntoConstraints = false
      builder = ConstraintBuilder.new(self)
      builder.instance_eval(&block)
      builder.install
      builder
    end

    # find closest common superview
    def closest_common_superview(second_view)
      closest_common_superview = nil
      second_view_superview = second_view
      while (!closest_common_superview && second_view_superview)
        first_view_superview = self
        while (!closest_common_superview && first_view_superview)
          if first_view_superview == second_view_superview
            closest_common_superview = second_view_superview
          end
          first_view_superview = first_view_superview.superview
        end
        second_view_superview = second_view_superview.superview
      end
      closest_common_superview
    end
  end
end

UIView.instance_eval do
  include Moria::LayoutAttributeExtension
  include Moria::LayoutExtension
  attr_accessor :moria_key
end