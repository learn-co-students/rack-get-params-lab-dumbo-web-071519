require 'bundler/setup'
Bundler.require

require_relative '../app/application'

desc "Console" do
def Console
Pry.new
end
end