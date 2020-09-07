# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require './lib/dotenv'
require 'bundler/setup'
Bundler.require 'default', ENV['RACK_ENV']

# require 'json'

# The App
class App < Sinatra::Base
  def self.logger
    @@logger ||= Logger.new STDOUT # rubocop:disable Style/ClassVars
  end

  before do
    @title = 'Speedtest Results'
  end

  get '/' do
    @results = File.readlines(ENV['SPEEDTEST_LOG_PATH']).map { |line| JSON.parse line }.reverse
    erb :index
  end
end
