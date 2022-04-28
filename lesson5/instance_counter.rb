module InstanceCounter
  def self.included(base)
    base.extend MethodClass
    base.include MethodInstance
  end
end

module MethodClass
  attr_accessor :instances

  def instances
    @instances ||= 0
  end
end

module MethodInstance

  def register_instance
    self.class.instances += 1
  end
end

