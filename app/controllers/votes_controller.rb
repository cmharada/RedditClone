class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      if @vote.votable_type == "Post"
        redirect_to post_url(@vote.votable.id)
      else
        redirect_to post_url(@vote.votable.post_id)
      end
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to subs_url
    end
  end
  
  private
  
  def vote_params
    params.require(:vote).permit(:value, :votable_id, :votable_type)
  end
end