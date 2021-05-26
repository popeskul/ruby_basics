require_relative 'modules/on'

module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        define_method(name) do
          instance_variable_get("@#{name}".to_sym)
        end

        define_method("#{name.to_sym}=") do |value|
          instance_variable_set("@#{name}".to_sym, value)
          instance_variable_set("@#{name}_history".to_sym, send("#{name}_history") << value)
        end

        define_method("#{name}_history") do
          instance_variable_get("@#{name}_history".to_sym) if instance_variable_defined?("@#{name}_history")
          instance_variable_set("@#{name}_history".to_sym, [])
        end
      end
    end

    def strong_attr_accessor(name, class_name)
      define_method(name) do
        instance_variable_get("@#{name}".to_sym)
      end

      define_method("#{name}=".to_sym) do |value|
        raise ValidationError, "Incorrect class of #{name} value!" unless value.class == class_name
        instance_variable_set("@#{name}".to_sym, value)
      end
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.send :attr_accessor_with_history, :strong_attr_accessor
    end
  end
end
