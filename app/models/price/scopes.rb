class Price < ApplicationRecord
  module Scopes
    def weekly
      where('created_at >= ?', 1.week.ago)
    end

    def daily_totals
      weekly.group_by{|x| x.created_at.strftime("%Y-%m-%d")}
    end

    def daily
      created_at.to_date.to_s(:db)
    end
  end
end
