
module MDO
  class Manager
    def initialize(output)
      @output = output
      @lists = {}
    end

    def add_list(name)
      if include_list? name
        p("There is already a list named '#{name}'.")
      elsif name.blank? 
        p("Impossible to add a list with blank name.")
      else
        @lists[name] = List.new(self, name)
        p("Created a new list named '#{name}'.")
      end
    end

    def add(list, element)
      add_list(list) unless include_list? list
      @lists[list] << element
    end

    def p message
      @output.puts(message)
    end

    private
    def include_list? name
      @lists.include?(name)
    end
  end
end
