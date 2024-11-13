class IdeasController < ApplicationController
  def create
    idea = Idea.new(idea_params)
    if idea.save
      render json: idea, message: "Idea is being process for market gate"
    else
      render json: idea, message: idea.errors.full_messages
    end
  end

  def index
    ideas = Idea.all
    render json: ideas.map { |idea| { id: idea.id, description: idea.description, title: idea.title, created: idea.created_at.getlocal.strftime("%B %d, %Y : %H:%M:%S") } }, message: "Idea Fetched Successfully"
  end

  def show
    idea = Idea.find_by(id: params[:id])
    render json: idea, message: "Idea Fetched Successfully"
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
