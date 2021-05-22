module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    def instances
      @instances ||= 0
    end

    private
    def increment_instances
      @instances += 1
    end
  end

  module InstanceMethods
    private
    def register_instance
      self.class.send :increment_instances
    end
  end
end
