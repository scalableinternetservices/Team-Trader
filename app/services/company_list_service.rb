class CompanyListService
  def self.getCompanyList(prefix)
    list = Company.all.select {
        |x| x.code.start_with? prefix
    }
    if not list.empty?
      return list.collect{
        |x| {:data=>x.code,:value => x.name.nil? ? '':x.name + '('  + x.code + ')' }
      }
    else
      return nil
    end
  end

end
