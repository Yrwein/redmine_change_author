class ChangeAuthorController < ApplicationController
  unloadable

  before_filter :require_admin

  def index
    @issue = Issue.find_by_id params[:id]
    @users = User.all
  end

  def edit
    issue = Issue.find_by_id params[:id]
    old_author = issue.author
    new_author = User.find_by_id params[:author_id]

    if old_author != new_author
      issue.author = new_author
      journal = issue.init_journal(User.current)
      journal.details << JournalDetail.new(:property => 'attr',
                                           :prop_key => :author,
                                           :old_value => old_author.name,
                                           :value => new_author.name)
      issue.save
    end
    redirect_to issue_path(issue)
  end
end
