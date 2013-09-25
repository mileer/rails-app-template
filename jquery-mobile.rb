# -*- coding: utf-8 -*-
unless /jquery_mobile_rails/ =~ File.read('Gemfile')
  gem 'jquery_mobile_rails'
  abort('run again after `bundle install`')
end

create_file 'app/assets/stylesheets/mobile.css', <<-CSS
/*
 *= require_self
 *= require jquery.mobile
 *= require_tree ./mobile
 */
CSS
create_file 'app/assets/stylesheets/mobile/.keep'

create_file 'app/assets/javascripts/mobile.js', <<-JS
//= require jquery
//= require jquery_ujs
//= require jquery.mobile
//= require_tree ./mobile
JS
create_file 'app/assets/javascripts/mobile/.keep'

create_file 'app/views/layouts/mobile.html.haml', <<-HAML
!!! 5
%html
  %head
    %meta(charset="utf-8")
    %meta(http-equiv="X-UA-Compatible" content="IE=edge,chrome=1")
    %meta(name="viewport" content="width=device-width, initial-scale=1")
    %meta(name="format-detection" content="telephone=no")
    = csrf_meta_tags
    %title= content_for?(:title) ? yield(:title) : @title
    = stylesheet_link_tag "mobile", media: "all"
    = javascript_include_tag "mobile"
  %body
    %div(data-role="page" data-theme="b")
      - if content_for?(:header)
        %div(data-role="header")
          = yield :header
      - elsif content_for?(:title)
        %div(data-role="header")
          %h1= yield :title
      %div(data-role="content")
        %p.notice= notice
        %p.alert= alert
        = yield
      - if content_for?(:footer)
        %div(data-role="footer")
          = yield :footer
HAML