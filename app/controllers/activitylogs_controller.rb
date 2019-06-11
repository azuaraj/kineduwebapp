class ActivitylogsController < ApplicationController

  def index
    if params[:activity_log] && params[:status].present?
      @activity_logs = ActivityLog.search(params[:activity_log], params[:status])
    else
      @activity_logs = ActivityLog.includes(:baby, :assistant, :activity).all
    end
  end
end
