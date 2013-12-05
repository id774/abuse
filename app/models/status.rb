# -*- coding: utf-8 -*-
class Status < ActiveRecord::Base
  validates :text, :presence => true,
                   :length => {:minimum => 1, :maximum => 140}
end
