class ChangeAuthorController < ApplicationController
  unloadable

  before_filter :require_admin

  def index
    @issue = Issue.find_by_id params[:id]
    @users = User.all
  end

  def edit
    issue = Issue.find_by_id params[:id]
    issue.author = User.find_by_id params[:author_id]
    issue.save
    redirect_to issue_path(issue)
  end
end
