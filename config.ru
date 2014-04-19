require 'rubygems'
require 'sass/plugin/rack'
require File.join(File.dirname(__FILE__), 'lib/family_weekend.rb')

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run FamilyWeekend