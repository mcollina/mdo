require 'yaml'

module MDO
  class Manager
    
    def initialize(output)
      @output = output
      @lists = []
    end

    def add(name)
      if get(name)
        p("There is already a list named '#{name}'.")
        nil
      elsif name.blank? 
        p("Impossible to add a list with blank name.")
        nil
      else
        @lists << List.new(name, self)
        p("Created a new list named '#{name}'.")
        @lists.last
      end
    end

    def find(list)
      get(list) || add(list)
    end

    def p message
      @output.puts(message)
    end

    def load(source)
      open(source) do |io|
        yaml = YAML.load(io.read)
        @lists = yaml if yaml
        @lists.each { |l| l.manager = self }
      end
    end

    def save(dest)
      open(dest, "w") do |io|
        io << @lists.to_yaml
      end
    end

    def display!
      p "There are no lists." if @lists.size == 0
      @lists.each_with_index do |list, index|
        p "#{index + 1}: #{list.name}."
      end
    end

    def get name
      @lists.find { |l| l.name == name }
    end

    alias :[] :get
  end
end
