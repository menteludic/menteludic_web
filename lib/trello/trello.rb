Dir[File.expand_path('./lib/**/*.rb', __dir__)].each {|file| require file }

module Trello
  class Main
    class << self
      def call(options)
        http = Trello::HTTP.new(options[:apiKey], options[:token])
        logger = Trello::Logger.new
        data = Trello::Data.new(options[:events])
        save = Trello::Save.new('events')
        data.subscribe(logger)
        data.subscribe(save)
        save.subscribe(logger)
        data.process(http)
      end
    end
  end
end
