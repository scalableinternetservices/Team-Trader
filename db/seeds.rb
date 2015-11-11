# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Populate company table after db setup
require 'csv'

# ActiveRecord::Base.transaction do
#   CSV.foreach(Rails.root.join('app','assets','csv','yahoo_stock_list.csv')) do |row|
#     cl = Company.create(code:row[0], name:row[2]);
#   end
# end

ActiveRecord::Base.transaction do
  CSV.foreach(Rails.root.join('app','assets','csv','NASDAQ.csv')) do |row|
    Index.create(symbol:row[0],name:row[1],market_cap:row[3],ipo_year:row[4],sector:row[5],industry:row[6],link:row[7],exchange:'NASDAQ');
  end
  CSV.foreach(Rails.root.join('app','assets','csv','AMEX.csv')) do |row|
    Index.create(symbol:row[0],name:row[1],market_cap:row[3],ipo_year:row[4],sector:row[5],industry:row[6],link:row[7],exchange:'AMEX');
  end
  CSV.foreach(Rails.root.join('app','assets','csv','NYSE.csv')) do |row|
    Index.create(symbol:row[0],name:row[1],market_cap:row[3],ipo_year:row[4],sector:row[5],industry:row[6],link:row[7],exchange:'NYSE');
  end
end


TermSearchHistory.delete_all

ActiveRecord::Base.transaction do
  CSV.foreach(Rails.root.join('app','assets','csv','20kwords.csv')) do |row|
    TermSearchHistory.create(term: row[0], count: Random.rand(100) +  1)
  end
end

