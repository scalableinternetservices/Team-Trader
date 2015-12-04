require 'CSV'
class RandomDataGenerator

  def self.generateUserAndPasswordCSV(numOfUser)
    # @file = 'UsernamePassword.csv'
    #Generate a lot of user in a CSV file
    @file =  '../assets/csv/UsernamePassword.csv'
    CSV.open(@file,'wb') do |csv|
      for i in 1...numOfUser
        t = Time.new
        csv << ['user'+t.hour.to_s + t.min.to_s + t.sec.to_s + i.to_s + '@gmail.com','12345678']
      end
    end
  end

  def self.createCompanyList
    @file =  '../assets/csv/CompanyList.csv'
    CSV.open(@file,'wb') do |csv|
      CSV.foreach('../assets/csv/AMEX.csv') do |row|
          csv << [row[1] + '(' + row[0] + ')']
          puts row[1] + '(' + row[0] + ')'
      end
      CSV.foreach('../assets/csv/NASDAQ.csv') do |row|
        csv << [row[1] + '(' + row[0] + ')']
        puts row[1] + '(' + row[0] + ')'
      end
      CSV.foreach('../assets/csv/NYSE.csv') do |row|
        csv << [row[1] + '(' + row[0] + ')']
        puts row[1] + '(' + row[0] + ')'
      end
    end
  end

  def self.generateHintsPrefix(numOfEntries)
    # @file = 'UsernamePassword.csv'
    @file =  '../assets/csv/HintsPrefix.csv'
    CSV.open(@file,'wb') do |csv|
      for i in 1...numOfEntries
        t = Time.new
        csv << ['user'+t.hour.to_s + t.min.to_s + t.sec.to_s + i.to_s + '@gmail.com','12345678']
      end
    end
  end
  # generateUserAndPasswordCSV(10000)
  # createCompanyList
end