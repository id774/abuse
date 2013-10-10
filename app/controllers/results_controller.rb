# -*- encoding: utf-8 -*-

require 'MeCab'
require 'fluent-logger'

class ResultsController < ApplicationController
  def index
    @fluentd = Fluent::Logger::FluentLogger.open('abuse',
      host = 'localhost', port = 9999)

    @arel_table = Status.arel_table
    session[:abuse] ||= ""

    nouns_array = pickup_nouns(session[:abuse])
    status = Status.where(generate_or_condition(nouns_array))
    @statuses = status.paginate(:page => params[:page], :order => "created_at DESC, id DESC")
    # @search = Status.search(params[:search], :order => "created_at DESC, id DESC")

    @fluentd.post('record', {
      :text => session[:abuse],
      :match => @statuses.length
    })

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

  def pickup_nouns(string)
    mecab = MeCab::Tagger.new("-Ochasen")
    node = mecab.parseToNode(string)
    nouns = []
    while node
      if /^名詞/ =~ node.feature.force_encoding("utf-8").split(/,/)[0] then
        nouns.push(node.surface.force_encoding("utf-8"))
      end
      node = node.next
    end
    nouns
  end
end
