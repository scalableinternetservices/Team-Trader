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


inserts = []
count = 100
CSV.foreach(Rails.root.join('app','assets','csv','UsernamePassword.csv')) do |row|
  if count == 0
    sql = "INSERT INTO users('email','encrypted_password','created_at','updated_at') VALUES #{inserts.join(", ")}"
    User.connection.execute sql
    count = 100
    inserts = []
  end
  inserts.push "('" + row[0] + "','" + '$2a$10$fjBAOlfNweP/M6JxT9wx4u72Vj2AlJxydsGO9gQ9QlS9eg0efKlpW' + "','" + "2015-12-04 06:08:36" + "','" + "2015-12-04 06:08:36" + "'" + ")"
  count = count - 1
end
sql = "INSERT INTO users('email','encrypted_password','created_at','updated_at') VALUES #{inserts.join(", ")}"
User.connection.execute sql