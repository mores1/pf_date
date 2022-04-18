class SpotCommentsController < ApplicationController

  def create
    spot = Spot.find(params[:spot_id])
    comment = current_user.spot_comments.new(spot_comment_params)
    comment.spot_id = spot.id
    comment.save
    redirect_to spot_path(spot)
  end

  def destroy
    SpotComment.find_by(id: params[:id], spot_id: params[:spot_id]).destroy
    redirect_to request.referer
  end

  private

  def spot_comment_params
    params.require(:spot_comment).permit(:comment)
  end

end
