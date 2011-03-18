require 'thor'

module MDO
  class CLI < Thor

    desc "add LIST ITEM", "Adds an item to a list."
    def add(list, element)
      load!
      list = manager.find(list)
      list.add(element) if list
      save!
    end

    desc "add_list LIST", "Creates a list."
    def add_list(list)
      load!
      manager.add(list)
      save!
    end

    private
    def manager
      @manager ||= Manager.new(output)
    end

    def output
      options[:output] || $stdout
    end

    def load!
      if File.exists? location
        manager.load(location)
      end
    end

    def save!
      manager.save(location)
    end

    def location
      options[:location] || MDO.default_location
    end
  end
end
