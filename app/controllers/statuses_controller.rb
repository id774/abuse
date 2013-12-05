# -*- encoding: utf-8 -*-

class StatusesController < ApplicationController
  def new
    @status = Status.new

    respond_to do |format|
      format.html
      format.json { render json: @status }
    end
  end

  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @status }
    end
  end

  def create
    @status = Status.new(status_params)
    session[:abuse] = @status.text

    respond_to do |format|
      notice = '罵倒文候補の一覧を表示します'
      format.html { redirect_to results_path,
        notice: notice }
      format.json { render json: @statuses, status: :created, location: @statuses }
    end
  end

  def index
    @statuses = Status.page(params[:page]).per(10).order(id: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @statuses }
    end
  end

  private
    def set_status
      @status = Status.find(params[:id])
    end

    def status_params
      params.require(:status).permit(:text)
    end
end
