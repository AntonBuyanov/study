# frozen_string_literal: true

# Моудль Validation предназначен для валидации атрибутов классов
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # Методы класса
  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(name, valid, *options)
      validations << { name: name, valid: valid, options: options }
    end
  end

  # Инстанс методы
  module InstanceMethods
    def validate!
      self.class.validations.each do |value|
        validate = (value[:valid]).to_s
        option = value[:options]
        value = instance_variable_get("@#{value[:name]}".to_sym)
        send(validate, value, *option)
      end
    end

    def presence(value)
      raise 'Название не может быть пустым!' if value.nil?
    end

    def format(value, format)
      raise 'Недопустимый формат!' if value !~ format
    end

    def type(value, type)
      raise 'Атрибут не соответствует классу!' unless value.is_a?(type)
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
