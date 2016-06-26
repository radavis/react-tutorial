require "sinatra"
# require "sinatra/json"
require "pry"

require_relative "./models/comment"

get "/api/comments" do
  comments = Comment.all
  json(comments)
end

post "/api/comments" do
  Comment.create(params) ? (status 200) : (status 404)
end
