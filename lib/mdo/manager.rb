
module MDO
  class Manager
    def initialize(output)
      @output = output
      @lists = []
    end

    def add_list(name)
      if blank? name
        @output.puts("Impossible to add a list with blank name.")
      elsif include? name
        @output.puts("There is already a list named '#{name}'.")
      else
        @lists << name
        @output.puts("Created a new list named '#{name}'.")
      end
    end

    def add(list, element)

    end

    def include? name
      @lists.include? name
    end

    private

    def blank? name
      name.nil? or name == ""
    end
  end
end
