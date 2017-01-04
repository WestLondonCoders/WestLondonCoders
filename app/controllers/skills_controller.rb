class SkillsController < ApplicationController

  def index
    @search = Skill.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @skills = @search.result.includes(:users)
  end

  def search
    index
    render :index
  end

  def show
    @skill = Skill.find_by(id: skill_params[:id])
  end

  private

  def skill_params
    params.permit(:id)
  end
end
