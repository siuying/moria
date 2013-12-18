module Moria
  # represent a attribute in a UIView
  class ViewAttribute
    attr_accessor :view
    attr_accessor :layout_attribute
    attr_accessor :constant

    def initialize(view, layout_attribute)
      @view = view
      @layout_attribute = layout_attribute
      @constant = nil
    end

    def size_attribute?
      layout_attribute == NSLayoutAttributeWidth || layout_attribute == NSLayoutAttributeHeight
    end

    def alignment_attribute?
      !size_attribute?
    end

    def offset(constant)
      self.constant = constant
      self
    end

    def ==(another)
      if another.is_a?(ViewAttribute)
        return view == another.view && layout_attribute == another.layout_attribute
      end

      return false
    end

  end
end