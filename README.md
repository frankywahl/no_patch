# NoPatch

Prevent monkey patching of classes

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'no_patch'
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


## Contributing

1. Fork it ( https://github.com/[my-github-username]/no_patch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
