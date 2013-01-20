# -*- coding: utf-8 -*-
class Status < ActiveRecord::Base
  self.per_page = 10

  validates :text, :presence => true,
                   :length => {:minimum => 1, :maximum => 140}
end
