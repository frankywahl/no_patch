# NoPatch

Prevent monkey patching of classes

## Installation

Add this line to your application's Gemfile:

```ruby
gem "no_patch"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install no_patch

## Usage

Include it as a module to any class.

```ruby
class MyClass
  include NoPatch
end
```

Now, it should raise errors when redefining a method that is already existent.

```ruby
class MyClass
  def foo
    puts "all good here"
  end
end
# => :foo

class MyClass
  def foo
    puts "Redefining"
  end
end

#=> raises NoPath::RedifinitionError
```

## Code Status
[![Build Status](https://travis-ci.org/frankywahl/no_patch.svg?branch=master)](https://travis-ci.org/frankywahl/no_patch)
[![Code Climate](https://codeclimate.com/github/frankywahl/no_patch/badges/gpa.svg)](https://codeclimate.com/github/frankywahl/no_patch)
[![Test Coverage](https://codeclimate.com/github/frankywahl/no_patch/badges/coverage.svg)](https://codeclimate.com/github/frankywahl/no_patch)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/no_patch/fork )
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request
