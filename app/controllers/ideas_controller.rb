class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  def create
    @idea = Idea.new(idea_params)
    @idea.save
    redirect_to user_path(@idea.user)
  end

  def edit
  end

  def update
    if @idea.update(idea_params)
      redirect_to @idea.user, notice: 'Your idea was successfully updated.'
    else
      render :edit
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description, :category_id, :user_id)
  end

  def set_idea
    @idea = Idea.find(params[:id])
  end
end
