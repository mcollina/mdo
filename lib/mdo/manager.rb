require 'yaml'

module MDO
  class Manager
    
    attr_reader :lists

    def initialize(output)
      @output = output
      @lists = {}
    end

    def add_list(name)
      if include_list? name
        p("There is already a list named '#{name}'.")
        nil
      elsif name.blank? 
        p("Impossible to add a list with blank name.")
        nil
      else
        @lists[name] = List.new(name, self)
        p("Created a new list named '#{name}'.")
      end
    end

    def add(list, element)
      if include_list? list or add_list(list)
        @lists[list] << element
      end
    end

    def p message
      @output.puts(message)
    end

    def load(source)
      open(source) do |io|
        yaml = YAML.load(io.read)
        @lists = yaml.to_hash if yaml.respond_to? :to_hash
        @lists.each_value { |l| l.manager = self }
      end
    end

    def save(dest)
      open(dest, "w") do |io|
        io << @lists.to_yaml
      end
    end

    private
    def include_list? name
      @lists.include?(name)
    end
  end
end
