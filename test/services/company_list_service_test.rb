require 'test_helper'
require 'company_list_service'
class CompanyListServiceTest < ActiveSupport::TestCase
  test 'Query a company with prefix' do
    val = CompanyListService.getCompanyList 'AP'
    assert_not_nil val
  end

end
