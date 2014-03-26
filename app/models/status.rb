# -*- coding: utf-8 -*-

class Status < ActiveRecord::Base
  paginates_per 10

  validates :text, :presence => true,
                   :length => {:minimum => 1, :maximum => 142}
end
