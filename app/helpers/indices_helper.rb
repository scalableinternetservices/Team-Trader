module IndicesHelper
  def cache_key_for_investment(inv)
    "investments/#{inv.id}/#{inv.updated_at}"
  end

  def cache_key_for_investments(investments)
    "investments/#{investments.maximum(:updated_at)}"
  end
end
