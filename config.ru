require 'rubygems' unless defined? ::Gem
require 'bundler'

Bundler.require
require File.dirname( __FILE__ ) + '/app'

run App