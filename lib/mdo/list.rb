
module MDO
  class List
    def initialize(manager, name)
      @elements = []
      @manager = manager
      @name = name
    end

    def add(element)
      if element.blank?
        p "Impossible to add a blank element to the 'first' list."
      else
        @elements << element
        p "Added the '#{element}' element to the '#{@name}' list in position #{@elements.size}."
      end
    end

    alias :<< :add

    private

    def p(message)
      @manager.p(message)
    end
  end
end
