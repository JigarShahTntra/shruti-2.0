require "redcarpet"

class IdeasController < ApplicationController
  before_action :set_idea, only: [ :show, :export_pdf ]

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
    render json: @idea, message: "Idea Fetched Successfully"
  end

  def export_pdf
    # Fetch data from the database for the report
    idea_data = @idea.attributes
    idea_data["ellaboration"] = markdown_to_html(idea_data["ellaboration"])
    criterias_data = @idea.criterias.uniq(&:criteria_type).sort_by(&:criteria_type).map do |criteria|
      cr_att = criteria.attributes
      cr_att["description"] = markdown_to_html(cr_att["description"])
      cr_mt_attr = criteria.criteria_mitigations.last.attributes
      cr_mt_attr["description"] = markdown_to_html(cr_mt_attr["description"])
      cr_att.merge(criteria_mitigations: cr_mt_attr)
    end
    # Render the PDF
    pdf = WickedPdf.new.pdf_from_string(ActionController::Base.new.render_to_string "ideas/export_pdf", locals: { idea_data:, criterias_data: })

    send_data pdf, filename: "T(u)LIP-#{@idea.title.downcase.dasherize}.pdf", type: "application/pdf", disposition: "attachment"
  end

  private

  def idea_params
    params.require(:idea).permit(:tid, :title, :description, :market_potential)
  end

  def markdown_to_html(markdown_text)
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    markdown.render(markdown_text)
  end

  def set_idea
    @idea = Idea.find_by(id: params[:id] || params[:idea_id])
  end
end
