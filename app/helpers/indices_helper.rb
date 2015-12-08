module IndicesHelper
  def cache_key_for_investment(inv)
    "investments/#{inv.id}/#{inv.updated_at}"
  end

  def cache_key_for_investments(investments)
     cache_key = "investments/#{investments.maximum(:updated_at)}"
     cache_key
  end
end
