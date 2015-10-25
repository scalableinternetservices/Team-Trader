require 'company_list_service'
class CompanyListController < ApplicationController

  #GET company_list/getHints, AJAX
  def getHints
    render json: {:suggestions => (CompanyListService.getCompanyList params[:query])}
  end
end
