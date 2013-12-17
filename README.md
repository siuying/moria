# Moria

Auto Layout in RubyMotion.

The concept:

```ruby
view1.layout do
  top     >= (superview.top).offset(padding)
  left    == (superview.left).offset(padding)
  bottom  == (view3.top).offset(-padding)
  right   == (view2.left).offset(-padding)
  width   == view2.width
  height  == [view2, view3]
end

view2.layout do
  top     >= (superview.top).offset(padding)
  left    == (superview.right).offset(padding)
  bottom  == (view3.top).offset(-padding)
  right   == (view2.right).offset(-padding)
  width   == view1.width
  height  == [view1, view3]
end

view3.layout do
  top     >= (view1.bottom).offset(padding)
  left    == (superview.left).offset(padding)
  bottom  == (superview.bottom).offset(-padding)
  right   == (superview.right).offset(-padding)
  height  == [view1, view2]
end

```

## Installation

Add this line to your application's Gemfile:

    gem 'moria'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moria

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
