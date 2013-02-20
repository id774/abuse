# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe ResultsController do
  fixtures :all

  context 'にアクセスする場合' do

    describe '一覧表示' do
      it "罵倒一覧が表示される" do
        get 'index'
        response.should be_success
      end
    end

  end
end
