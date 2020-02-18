class AstronomyController < ApplicationController

  def index
  end

  def lunar_phase
    @results = AstronomyXmltimeConnection.lunar_phase params[:date]
    if @results.is_a?(Hash) && @results.keys.include?("errors")
      handle_error @results["errors"]
    else
      respond_to do |format|
        format.json { render json: @results }
        format.js { render "lunar_phase_results" }
      end
    end
  end

  def handle_error errors
    flash[:danger] = errors.join("\n")
    redirect_to root_path
  end
end