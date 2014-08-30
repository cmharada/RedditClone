class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      redirect_to subs_url
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
