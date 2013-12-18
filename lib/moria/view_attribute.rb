module Moria
  # represent a attribute in a UIView
  class ViewAttribute
    attr_accessor :view
    attr_accessor :layout_attribute

    def initialize(view, layout_attribute)
      @view = view
      @layout_attribute = layout_attribute
    end

    def size_attribute?
      layout_attribute == NSLayoutAttributeWidth || layout_attribute == NSLayoutAttributeHeight
    end
  end
end