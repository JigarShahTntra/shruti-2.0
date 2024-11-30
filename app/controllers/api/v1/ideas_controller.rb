require "redcarpet"
require "zip"

class Api::V1::IdeasController < ::ApplicationController
  before_action :set_idea, only: [ :show, :export_pdf, :stage_gates ]

  def create
    idea = Idea.new(idea_params)
    if idea.save
      render json: idea, message: "Idea is being process for stage gates."
    else
      render json: idea, message: idea.errors.full_messages
    end
  end

  def index
    ideas = Idea.all
    render json: ideas.map { |idea| { id: idea.id, description: idea.description, title: idea.title, created: idea.created_at.getlocal.strftime("%B %d, %Y : %H:%M:%S") } }, message: "Ideas Fetched Successfully"
  end

  def show
    render json: @idea, message: "Idea Fetched Successfully"
  end

  def export_pdf
    # Fetch data from the database for the report
    pdfs = []
    idea_data = @idea.attributes
    idea_data["elaboration"] = markdown_to_html(idea_data["elaboration"])
    stage_gates_data = @idea.idea_stage_gates.sort_by(&:stage_gate_id).map do |idea_stage_gate|
      {
        "#{idea_stage_gate.stage_gate.name}": idea_stage_gate.idea_parameter_details.sort_by(&:stage_gate_parameter_id).uniq(&:stage_gate_parameter_id).map do |parameter|
          {
            "#{parameter.name}": markdown_to_html(parameter.description),
            "mitigation": markdown_to_html(parameter&.idea_parameter_recommendation_detail&.description)
          }
        end
      }
    end

    stage_gates_data.each do |stage_gate|
      pdfs << { filename: "#{stage_gate.keys.first.to_s.downcase.gsub(' ', '-')}.pdf", content: WickedPdf.new.pdf_from_string(ActionController::Base.new.render_to_string "ideas/export_pdf", locals: { idea_data:, stage_gate: }) }
    end

    zipfile = Tempfile.new("T(u)LIP-#{@idea.tid}-stage-gate-reports.zip")
    Zip::File.open(zipfile.path, Zip::File::CREATE) do |zip|
      pdfs.each do |pdf|
        zip.get_output_stream(pdf[:filename]) { |f| f.write(pdf[:content]) }
      end
    end

    zipfile.close
    zipfile.open

    send_data zipfile.read, type: "application/zip", disposition: "attachment", filename: "T(u)LIP-#{@idea.tid}-stage-gate-reports.zip"
  ensure
    zipfile.close
    zipfile.unlink
  end

  def stage_gates
    render json: @idea.stage_gates, message: "Stage Gates Fetched Successfully."
  end

  private

  def idea_params
    params.require(:idea).permit(:tid, :title, :description, :market_potential, :intellectual_property_potential, :technology_requirements, :compliance_aspect, :business_model)
  end

  def markdown_to_html(markdown_text)
    return if markdown_text.blank?

    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true, fenced_code_blocks: true, lax_spacing: true)
    markdown.render(markdown_text)
  end

  def set_idea
    @idea = Idea.find_by(tid: params[:id] || params[:idea_id])
  end
end
