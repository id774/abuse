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
    @status = Status.new(params[:status])
    session[:abuse] = @status.text

    respond_to do |format|
      notice = '罵倒文候補の一覧を表示します'
      format.html { redirect_to results_path,
        notice: notice }
      format.json { render json: @statuses, status: :created, location: @statuses }
    end
  end

  def index
    @search = Status.search(params[:search], :order => "created_at DESC, id DESC")
    @statuses = @search.paginate(:page => params[:page], :order => "created_at DESC, id DESC")

    respond_to do |format|
      format.html
      format.json { render json: @statuses }
    end
  end
end

class BootstrapPaginationRenderer < WillPaginate::ActionView::LinkRenderer
  private
  def previous_or_next_page(page, text, classname)
    link(text, page, :class => classname) unless page == false
  end

  public
  def to_html
    html = pagination.map do |item|
      tag(:li,
        ((item.is_a?(Fixnum))?
          page_number(item) :
          send(item)))
    end.join(@options[:link_separator])

    html = tag(:ul, html)

    @options[:container] ? html_container(html) : html
  end
end
