# -*- coding: utf-8 -*-
class AdminsController < ApplicationController
  before_filter :authenticate if RailsApp::Application.config.basic_auth

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    @status.text = @status.text.force_encoding("UTF-8")

    respond_to do |format|
      words = @status.text.length
      if words > 134 and words < 143
        if @status.save
          notice = '罵倒文が登録されました'
          format.html { redirect_to new_admin_path,
            notice: notice }
          format.json { render json: @statuses, status: :created, location: @statuses }
        end
      else
        notice = '入力文字数が長すぎるか短すぎます'
        format.html { redirect_to new_admin_path,
          notice: notice }
      end
    end
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def status_params
    params.require(:status).permit(:text)
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == RailsApp::Application.config.username &&
      password == RailsApp::Application.config.password
    end
  end
end
