require 'yaml'

module MDO
  class List
    attr_accessor :manager

    def initialize(name, manager)
      @elements = []
      @manager = manager
      @name = name
    end

    def add(element)
      if element.blank?
        p "Impossible to add a blank element to the 'first' list."
      else
        @elements << element
        puts_element(@elements.size - 1)
      end
    end

    alias :<< :add

    def to_yaml_properties
      yaml_properties = super
      yaml_properties.delete("@manager")
      yaml_properties
    end

    def display!
      p "There are no elements." if @elements.size == 0

      @elements.each_index do |index|
        puts_element(index)
      end
    end

    private

    def p(message)
      @manager.p(message)
    end

    def puts_element(index)
      p "#{index + 1}: #{@elements[index]}."
    end
  end
end
