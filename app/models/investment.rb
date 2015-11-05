class Investment < ActiveRecord::Base
  belongs_to :user
  def overall_gain (live_price)

    overall_gain = (live_price - buyPrice)*quantity
    return overall_gain
  end

  def overall_gain_percent(live_price)
    gain = overall_gain(live_price)
    denom = buyPrice*quantity
    return gain/denom
  end

  def total_investment
    buyPrice*quantity
  end

  def total_value (live_price)
    live_price*quantity
  end

  def profit (live_price)
    total_value(live_price) - total_investment
  end


end
