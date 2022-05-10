# frozen_string_literal: true

# Модуль InstanceCounter включает в себя модули MethodClass и MethodInstance
module InstanceCounter
  def self.included(base)
    base.extend MethodClass
    base.include MethodInstance
  end

  # модуль MethodClass возвращает количество экземпляров класса
  module MethodClass
    attr_writer :instances

    def instances
      @instances || 0
    end
  end

  # модуль MethodInstance увеличивает счетчик количества экземпляров класса
  module MethodInstance
    def register_instance
      self.class.instances += 1
    end
  end
end
