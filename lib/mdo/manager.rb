
module MDO
  class Manager
    def initialize(output)
      @output = output
      @lists = []
    end

    def add_list(name)
      if include_list? name
        p("There is already a list named '#{name}'.")
      elsif blank_list_name? name
        p("Impossible to add a list with blank name.")
      else
        @lists << name
        p("Created a new list named '#{name}'.")
      end
    end

    def add(list, element)

    end

    private
    def include_list? name
      @lists.include?(name)
    end

    def blank_list_name? name
      (name.nil? or name == "")
    end

    def p message
      @output.puts(message)
    end
  end
end
