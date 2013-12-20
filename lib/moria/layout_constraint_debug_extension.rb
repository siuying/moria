module Moria
  module LayoutConstraintDebugExtension
    RELATION_DESCRIPTION = {
      NSLayoutRelationEqual => "==",
      NSLayoutRelationGreaterThanOrEqual => ">=",
      NSLayoutRelationLessThanOrEqual => "<="
    }

    ATTRIBUTE_DESCRIPTION = {
      NSLayoutAttributeTop => "top",
      NSLayoutAttributeLeft => "left",
      NSLayoutAttributeBottom => "bottom",
      NSLayoutAttributeRight => "right",
      NSLayoutAttributeLeading => "leading",
      NSLayoutAttributeTrailing => "trailing",
      NSLayoutAttributeWidth => "width",
      NSLayoutAttributeHeight => "height",
      NSLayoutAttributeCenterX => "centerX",
      NSLayoutAttributeCenterY => "centerY",
      NSLayoutAttributeBaseline => "baseline"
    }

    PRIORITY_DESCRIPTION = {
      UILayoutPriorityDefaultHigh => "high",
      UILayoutPriorityDefaultLow => "low",
      UILayoutPriorityRequired => "required"
    }

    def description_for_object(obj)
      return "#{obj.class}:#{obj.moria_key}" if obj.respond_to?(:moria_key) && obj.moria_key
      return "#{obj.class}:0x#{object_id.to_s(16)}"
    end

    def description
      description = ["<"]
      description << description_for_object(self)
      description << " " + description_for_object(firstItem)
      description << "." + ATTRIBUTE_DESCRIPTION[self.firstAttribute] if self.firstAttribute != NSLayoutAttributeNotAnAttribute
      description << " " + RELATION_DESCRIPTION[relation]
      description << " " + description_for_object(secondItem) if secondItem
      description << "." + ATTRIBUTE_DESCRIPTION[secondAttribute] if secondAttribute != NSLayoutAttributeNotAnAttribute
      description << " * #{multiplier}" if multiplier != 1

      if constant && constant.abs > 0
        if secondAttribute == NSLayoutAttributeNotAnAttribute
          description << " #{constant}"
        else
          description << " #{constant < 0 ? '-' : '+'} #{constant.abs}"
        end
      end

      description << " ^" + (PRIORITY_DESCRIPTION[priority] || "@#{priority}") if priority != UILayoutPriorityRequired

      description << ">"
      description.join('')
    end
  end

  def self.install_debug_extension
    NSLayoutConstraint.instance_eval do
      include Moria::LayoutConstraintDebugExtension
    end
  end
end