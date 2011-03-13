
module MDO
  autoload :Manager, File.join(File.dirname(__FILE__), "mdo", "manager")
  autoload :List, File.join(File.dirname(__FILE__), "mdo", "list")
end

class String
  # TODO check if this method is already here
  def blank?
    self == ""
  end
end

class << nil
  # TODO check if this method is already here
  def blank?
    true
  end
end
