# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#Populate company table after db setup
#require "CSV"

#CSV.foreach(Rails.root.join('app','assets','csv','yahoo_stock_list.csv')) do |row|
#  cl = Company.create(code:row[0], name:row[2]);
#end