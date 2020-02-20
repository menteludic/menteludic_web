require 'rainbow'
require 'awesome_print'

module Trello
  class Logger
    def log(msg, color)
      puts format(msg, color)
    end

    def info(message)
      log(message, :blue)
    end

    def error(message)
      log(message, :red)
    end

    def warning(message)
      log(message, :yellow)
    end

    def ok(message)
      log(message, :green)
    end

    def ap(object)
      log(object.ai, :blue)
    end

    def getRequest(url, query, response)
      info("#{url} (#{query.inspect})")
      error("#{response.code}: #{response.body}") unless response.code == 200
    end

  private

    def format(msg, color)
      Rainbow(msg).color(color)
    end
  end
end