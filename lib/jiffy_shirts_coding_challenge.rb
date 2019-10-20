# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'json'
require_relative 'product'
require_relative 'pack'
require_relative 'pack/collection'
require_relative 'order'
require_relative 'order/item'
require_relative 'order/packer'
require_relative 'order/collection'
require_relative 'utils'

Money.locale_backend = nil
