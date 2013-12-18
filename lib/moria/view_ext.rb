module Moria
  module LayoutAttributeExtension
    LAYOUT_ATTRIBUTES = {
      :left => NSLayoutAttributeLeft,
      :top => NSLayoutAttributeTop,
      :right => NSLayoutAttributeRight,
      :bottom => NSLayoutAttributeBottom,
      :leading => NSLayoutAttributeLeading,
      :trailing => NSLayoutAttributeTrailing,
      :width => NSLayoutAttributeWidth,
      :height => NSLayoutAttributeHeight,
      :centerX => NSLayoutAttributeCenterX,
      :centerY => NSLayoutAttributeCenterY,
      :baseline => NSLayoutAttributeBaseline
    }

    LAYOUT_ATTRIBUTES.each do |key, value|
      define_method(key) do
        ViewAttribute.new self, value
      end
    end
  end

  module LayoutExt
    def layout(&block)
      builder = ConstraintBuilder.new(self)
      builder.instance_eval(&block)
      builder.install
    end
  end
end

UIView.instance_eval do
  include Moria::LayoutAttributeExtension
  include Moria::LayoutExt
end