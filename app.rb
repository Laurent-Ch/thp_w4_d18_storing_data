require 'bundler'
Bundler.require

# Version of this command proposed by Rubocop:
# $:.unshift File.expand_path('lib/app', __dir__)
$:.unshift File.expand_path('lib/app', __dir__)
require 'scrapper'

# Setting up a new Scrapper instance/object
my_scrap = Scrapper.new

# Gettin the raw output of the main scrapper method
print raw_data = my_scrap.get_data

# Converting the raw data into json and saving it into a dedicated file
# WORKS !
# my_scrap.save_as_JSON(raw_data)

# Getting data from a Google spreadsheet
# WORKS !
# my_scrap.save_as_spreadsheet(raw_data)
# see at: https://docs.google.com/spreadsheets/d/1ycx7kI41K6XXSHVkO8ZgWW8WFGFw1mWBJBDFNsuwdGA/edit#gid=0

# Putting data into a csv file
# WORKS !
# my_scrap.save_as_csv(raw_data)
