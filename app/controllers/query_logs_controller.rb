class QueryLogsController < ApplicationController
  def index
    @query_logs = QueryLog.all
  end
end
