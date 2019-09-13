require 'rack/session/cookie'
require './app'


STDOUT.sync = true

run App
