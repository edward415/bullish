class CommentsController < ApplicationController

  def create_comment
    @event_id = params[:event]
    @content = params[:content]
    @comment = current_user.comments.build(event_id: @event_id, content: @content)
    
    if @comment.save
      flash[:notice] = "Your Comment was saved!"
      redirect_to feed_index_path
    else
      flash[:alert] = "Failed to create comment, please try again."
      redirect_to feed_index_path
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:event_id, :content)
  end
    
end
