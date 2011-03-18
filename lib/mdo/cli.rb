require 'thor'

module MDO
  class CLI < Thor

    desc "add LIST ITEM", "Adds an item to a list."
    def add(list, *element)
      load_and_save do
        find(list) { |list| list.add(element.join(" ")) }
      end
    end

    desc "add_list LIST", "Creates a list."
    def add_list(list)
      load_and_save do
        manager.add(list)
      end
    end

    desc "show LIST", "show the lists elements"
    def show(list)
      load_and_save do
        find(list) { |l| l.display! }
      end
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

    def find(list)
      list = manager.find(list)
      yield list if list
    end

    def load_and_save
      load!
      yield
      save!
    end
  end
end
