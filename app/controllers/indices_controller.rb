class IndicesController < ApplicationController
  #GET /hints
  def hints
    respond_to do |format|
      records = Index.where("symbol LIKE :prefix", prefix: "#{params[:query]}%")
      format.json {render json:{:suggestions => formatHints(records)}}
    end
  end



  def index

  end

  private
  def formatHints(records)
    if not records.empty?
      return records.collect{
          |x| {:data=>x.symbol,:value => x.name.nil? ? '':x.name + '('  + x.symbol + ')' }
      }
    else
      return {}
    end
  end
end
