module ActiveRecord
  class Base
    class << self
      attr_reader :templates

      def json(name, data = nil)
        @templates ||= {}
        return @templates[name] || {} unless data
        @templates[name] = data
      end
    end

    def render(template)
      as_json self.class.templates[template]
    end
  end

  class Relation
    def render(template)
      to_a.map { |item| item.render(template) }
    end
  end
end
