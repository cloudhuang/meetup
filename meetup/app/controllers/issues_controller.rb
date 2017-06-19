class IssuesController < ApplicationController
  def show
  	@issue = Issue.find(params[:id])
  	@comments = @issue.comments
  end

  def new
    if not current_user
      flash[:notice] = "请登陆后再发布活动！"
      redirect_to :root
      return
    else
      @issue = Issue.new
    end
  end

  def create
    issue = Issue.new(issue_params)
    issue.user_id = current_user.id
    issue.save

    flash[:notice] = "活动发布成功!"
    redirect_to :root
  end

  def edit
  	@issue = Issue.find(params[:id])

    if @issue.user.id != current_user.id
      flash[:notice] ="没有修改该活动的权限!"

      redirect_to @issue
    end
  end

  def update
  	issue = Issue.find(params[:id])
  	issue.update_attributes(issue_params)
  	redirect_to issue
  end

  def destroy
  	issue = Issue.find(params[:id])
  	issue.destroy
  	redirect_to :root
  end

	private
	def issue_params
	  params.require(:issue).permit(:title, :content)
	end
end
