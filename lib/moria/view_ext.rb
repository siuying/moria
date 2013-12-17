module Moria
  module ViewExt
    def layout(&block)
      builder = ConstraintBuilder.new(self)
      builder.instance_eval(&block)
      builder.install
    end

    def top
    end

    def left
    end

    def right
    end

    def bottom
    end
  end
end

UIView.instance_eval do
  include Moria::ViewExt
end