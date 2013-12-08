[![Code Climate](https://codeclimate.com/github/spectator/linked-list.png)](https://codeclimate.com/github/spectator/linked-list)
[![Build Status](https://secure.travis-ci.org/spectator/linked-list.png?branch=master)](http://travis-ci.org/spectator/linked-list)

# LinkedList

Ruby implementation of Linked List, following some Ruby idioms.

## Installation

Add this line to your application's Gemfile:

    gem 'linked-list'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linked-list

## Usage

    object = Object.new # could be anything
    list = LinkedList::List.new

    list.push(object)
    list << object # same as `push`

    list.unshift(object)

    list.pop
    list.shift

    list.reverse
    list.reverse!

    list.each      # Enumerator object
    list.each { |e| puts e }

    list.first     # head of the list
    list.last      # tail of the list

    list.to_a

Please see `LinkedList::List` and `LinkedList::Node` for details.

## TODO

* Insert / delete in the middle
* Contatenation of multiple linked lists
* More readable `inspect`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
