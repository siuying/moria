# Moria

Auto Layout in RubyMotion.

The concept:

```ruby
view1.create_constraint do
  top     >= (superview.top).offset(padding)
  left    == (superview.left).offset(padding)
  bottom  == (view3.top).offset(-padding)
  right   == (view2.left).offset(-padding)
  width   == view2.width
  height  == [view2, view3]
end

view2.create_constraint do
  top     >= (superview.top).offset(padding)
  left    == (view1.right).offset(padding)
  bottom  == (view3.top).offset(-padding)
  right   == (superview.right).offset(-padding)
  width   == view1.width
  height  == [view1, view3]
end

view3.create_constraint do
  top     >= (view1.bottom).offset(padding)
  left    == (superview.left).offset(padding)
  bottom  == (superview.bottom).offset(-padding)
  right   == (superview.right).offset(-padding)
  height  == [view1, view2]
end

```

## Status

Partially working, see examples in ```app/```

## About

The idea is definitely steal from [Masonry](https://github.com/cloudkite/Masonry), replace the objective-c and
function hacking with ruby superpower.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
