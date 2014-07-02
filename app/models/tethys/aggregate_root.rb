module Tethys
  module AggregateRoot
    extend ActiveSupport::Concern

    module ClassMethods
      def events(&block)
        instance_eval(&block)
      end

      # TODO: Move this into an evaluation context, instead of polluting the
      # aggregate.
      def on name, *attrs, &block
        struct = Struct.new(name.to_s.camelize, *attrs) do
          singleton_class.class_eval do
            define_method :applicator do
              block
            end
            define_method :inspect do
              "#<#{name.to_s.camelize} (#{members.map(&:to_s).join(", ")})>"
            end
          end
        end
        const_set name.to_s.camelize, struct
      end
    end

    def initialize
      @uncommitted_events = []
    end

    attr_accessor :id
    attr_reader :uncommitted_events

    def load_from_history(events)
      events.each do |event|
        apply_event(event)
      end
    end

    private

    def raise_event event
      @uncommitted_events << event
      apply_event(event)
    end

    def apply_event event
      instance_exec event, &event.class.applicator
    end
  end
end
