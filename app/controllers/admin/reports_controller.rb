module Admin
  class ReportsController < Admin::BaseController
    def index
      p params
      from = params["start_date"] || (Time.now.midnight - 5.day)
      to = params["end_date"]

      @orders = Order.by_date(from, to)
    end
  end
end