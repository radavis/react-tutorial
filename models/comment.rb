require "json"
require "pry"

class Comment
  class << self
    FILENAME = File.join([File.dirname(__FILE__), "..", "data", "comments.json"])

    def all
      result = []
      comments.each do |comment_params|
        result << Comment.new(comment_params)
      end
      result
    end

    def create(params)
      comment = Comment.new(params)
      if comment.valid?
        save(comment)
        return true
      else
        return false
      end
    end

    private

    def comments
      JSON.parse(data)
    end

    def data
      File.read(FILENAME)
    end

    def save(comment)
      result = comments
      result << comment.to_h
      result = JSON.pretty_generate(result)
      File.write(FILENAME, result)
    end
  end

  attr_reader :id, :author, :text

  def initialize(params)
    @id = params["id"]
    @author = params["author"]
    @text = params["text"]
  end

  def to_json(options = {})
    JSON.pretty_generate(to_h, options)
  end

  def to_h
    {
      "id" => id,
      "author" => author,
      "text" => text
    }
  end

  def valid?
    fields = [id, author, text]
    !(fields.include?(nil) || fields.include?(""))
  end
end
