# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe HomesController, 'アプリケーションのトップページ' do
  context 'にログイン無しでアクセスする場合' do
    it 'トップページが表示される' do
      get 'index'
      response.should be_success
    end
  end
end
