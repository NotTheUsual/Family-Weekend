require_relative 'base'
require 'word-to-markdown'
require 'pry'

class NewsController < Base

  get '/news/add' do
    redirect_if_not_admin
    haml :"/news/new"
  end

  post '/news/convert' do
    doc = params[:file][:tempfile]
    wtm_doc = WordToMarkdown.new(doc)
    string = '{ "post": { "body": "' + wtm_doc.to_s + '" } }'
    content_type :json
    json = string.gsub(/\n/, '\\n').to_json
  end

  get '/news/manage' do
    @news_posts = NewsPost.all
    haml :'/news/manage'
  end

  get '/news/:id' do |id|
    @post = NewsPost.first(id)
    haml :'/news/show'
  end

  get '/news/:id/edit' do |id|
    @post = NewsPost.get(id)
    haml :'/news/edit'
  end

  get '/news/:id/json' do |id|
    post = NewsPost.get(id)
    content_type :json
    {title: post.title, body: post.body}.to_json
  end

  post '/news' do
    post = NewsPost.create(news_post_params)
    redirect to("/news/#{post.id}")
  end

  private

  def news_post_params
    {
      title: params[:post][:title],
      body: params[:post][:body],
      created_at: Time.now
    }
  end
end

