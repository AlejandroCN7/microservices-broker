#!/usr/bin/env ruby

# De https://developer.github.com/webhooks/configuring/

require 'sinatra'
require 'json'
require 'httparty'
require 'pp'

set :port, 31415

# Descarga las diferencias hechas para un push
post '/' do
  push = JSON.parse(request.body.read)
  piezas = push["compare"].split("/")
  api_url = "/repos/#{piezas[3]}/#{piezas[4]}/compare/#{piezas[6]}"
  res = HTTParty.get("https://api.github.com#{api_url}")
  pp( res )
  diff_data = res.parsed_response
  pp(diff_data)
end
