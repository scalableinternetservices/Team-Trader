require 'trie'
class IndicesController < ApplicationController

  @@trie = Trie.new
  @@initialized = false

  def initialize
    super
    if not @@initialized
      Index.all.each do |c|
        @@trie.add c.name+'('+c.symbol+')'
      end
      @@initialized = true
    end
  end

  #GET /hints
  # def hints
  #   respond_to do |format|
  #     # records = Index.where("symbol LIKE :prefix", prefix: "#{params[:query]}%")
  #     format.json {render json:{:suggestions => getIndices(params[:query])}}
  #   end
  # end


  def index

  end

  # private
  def getIndices(prefix)
    children = @@trie.children(prefix)
    if children.empty?
      return {}
    else
      return children.collect{
          |c| {:data=>/.*\((.*)\)/.match(c)[1], :value=>c}
      }
    end
  end





  def hints
    respond_to do |format|
      records = Index.where("symbol LIKE :prefix", prefix: "#{params[:query]}%")
      format.json {render json:{:suggestions => formatHints(records)}}
    end
  end
  #
  #
  #
  # def index
  #
  # end
  #
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






