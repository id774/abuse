# -*- encoding: utf-8 -*-

require 'MeCab'

class ResultsController < ApplicationController
  def index
    @arel_table = Status.arel_table
    wakati_array = wakati_split(session[:abuse])
    status = Status.where(generate_or_condition(wakati_array))
    @statuses = status.paginate(:page => params[:page], :order => "created_at DESC, id DESC")
    @search = Status.search(params[:search], :order => "created_at DESC, id DESC")

    respond_to do |format|
      format.html
      format.json { render json: @statuses }
    end
  end

  private
  def generate_or_condition(fields)
    conditions = nil
    fields.each {|field|
      if conditions.nil?
        conditions = @arel_table[:text].matches("%" + field + "%")
      else
        conditions = conditions.or(@arel_table[:text].matches("%" + field + "%"))
      end
    }
    conditions
  end

  def wakati_split(string)
    wakati = MeCab::Tagger.new('-O wakati')
    wakati.parse(string).split(" ")
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
