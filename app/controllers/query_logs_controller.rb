class QueryLogsController < ApplicationController
  def index
    @query_logs = QueryLog.all
    @query_counts = QueryLog.joins("INNER JOIN populations ON populations.year = query_logs.year").distinct.group(:year).count
  end
end
