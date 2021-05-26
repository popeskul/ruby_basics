module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :to_validate

    def validate(name, validation_type, *args)
      @to_validate ||= {} # init if not nil
      @to_validate[name] ||= []
      @to_validate[name] << {
        method: "validate_#{validation_type}!",
        args: args
      }
    end
  end

  module InstanceMethods
    def validate!
      self.class.to_validate.each do |key, value|
        value.each do |validation_args|
          method_name = validation_args[:method]
          args        = validation_args[:args][0]
          send(method_name, instance_variable_get("@#{key}"), args)
        end
      end
      true
    end

    def validate_presence!(var, *args)
      raise "Variable #{var} is nil" if var.nil?
    end

    def validate_format!(var, format_string)
      message = "Variable #{var} hasn't acceptable format #{format_string}"
      raise message unless var =~ format_string
    end

    def validate_type!(var, checking_class)
      message = "#{var} has wrong class. Right is #{checking_class}"
      raise message unless var.class == checking_class
    end

    def valid?
      validate!
    rescue StandardError => e
      puts e.message
      false
    end
  end
end
