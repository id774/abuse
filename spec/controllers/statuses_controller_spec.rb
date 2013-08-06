# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe StatusesController do
  fixtures :all

  context 'にアクセスする場合' do

    describe 'トップページ' do
      it "トップページが表示される" do
        get 'new'
        response.should be_success
      end
    end

    describe '一覧表示' do
      it "罵倒一覧が表示される" do
        get 'index'
        response.should be_success
      end
    end

    describe '詳細' do
      it "詳細が表示される" do
        get 'show', :id => 4
        response.should be_success
      end
    end

    describe '送信' do
      context '罵倒対象の字句を送信する' do
        it "罵倒文候補が表示される" do
          post 'create', :status => {
            "text" => "死",
          }

          status = Status.find(4)

          response.should be_redirect
          response.redirect_url.should == 'http://test.host/results'
          response.header.should have_at_least(1).items
          response.body.should have_at_least(1).items
          flash[:notice].should_not be_nil
          flash[:notice].should == '罵倒文候補の一覧を表示します'
        end
      end
    end

    describe '送信' do
      context '罵倒対象の文章を送信する' do
        it "罵倒文候補が表示される" do
          post 'create', :status => {
            "text" => "みんなでワイワイ！定時出社！社会は厳しい！",
          }

          status = Status.find(4)

          response.should be_redirect
          response.redirect_url.should == 'http://test.host/results'
          response.header.should have_at_least(1).items
          response.body.should have_at_least(1).items
          flash[:notice].should_not be_nil
          flash[:notice].should == '罵倒文候補の一覧を表示します'
        end
      end
    end

  end
end
