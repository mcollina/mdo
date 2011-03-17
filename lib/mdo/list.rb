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
        p "Added the '#{element}' element to the '#{@name}' list in position #{@elements.size}."
      end
    end

    alias :<< :add

    def to_yaml_properties
      yaml_properties = super
      yaml_properties.delete("@manager")
      yaml_properties
    end

    private

    def p(message)
      @manager.p(message)
    end
  end
end
