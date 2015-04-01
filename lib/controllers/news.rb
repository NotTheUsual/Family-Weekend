require_relative 'base'
require 'word-to-markdown'
require 'pry'

class NewsController < Base
  use Rack::MethodOverride

  get '/news/add' do
    redirect_if_not_admin
    haml :"/news/new"
  end

  post '/news/convert' do
    content_type :json
    as_json_string params[:file][:tempfile]
  end

  get '/news/manage' do
    redirect_if_not_admin
    @news_posts = NewsPost.all
    haml :'/news/manage'
  end

  get '/news/:id' do |id|
    redirect_if_logged_out
    @post = NewsPost.get(id)
    haml :'/news/show'
  end

  put '/news/:id' do |id|
    @post = NewsPost.get(id)
    @post.update(title: params[:post][:title], body: params[:post][:body])
    haml :'/news/show'
  end

  get '/news/:id/edit' do |id|
    redirect_if_not_admin
    @post = NewsPost.get(id)
    haml :'/news/edit'
  end

  get '/news/:id/json' do |id|
    post = NewsPost.get(id)
    content_type :json
    {title: post.title, body: post.body}.to_json
  end

  get '/news' do
    redirect_if_logged_out
    @news_posts = NewsPost.all(order: [ :created_at.desc ])
    haml :'news/all'
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

  def as_json_string(doc)
    wtm_doc = WordToMarkdown.new(doc)
    string = '{ "post": { "body": "' + wtm_doc.to_s + '" } }'
    string.gsub(/\n/, '\\n').to_json
  end
end

