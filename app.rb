require 'bundler'
Bundler.require

$:.unshift File.expand_path('./../lib/app', __FILE__)
require 'scrapper'

# Setting up a new Scrapper instance/object
my_scrap = Scrapper.new

# Gettin the raw output of the main scrapper method
raw_data = my_scrap.get_data

# Converting the raw data into json and saving it into a dedicated file
my_scrap.save_as_JSON(raw_data)



