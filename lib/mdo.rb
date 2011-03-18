
module MDO
  autoload :Manager, "mdo/manager"
  autoload :List, "mdo/list"
  autoload :CLI, "mdo/cli"

  def self.user_home_dir
    ENV[["HOME", "HOMEPATH"].detect { |h| ENV[h] != nil }]
  end

  def self.default_location
    File.join(user_home_dir, ".mdo")
  end
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
