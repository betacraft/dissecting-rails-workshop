class Event
  @@max_id = 0
  @events = []

  attr_reader   :id
  attr_accessor :title

  def initialize(event_hash)
    @title = event_hash[:title]
  end

  def valid?
    !(title.nil? || title.empty?)
  end

  class << self
    attr_reader :events

    def event(event_id)
      event_idx = events.find_index { |event| event.id == event_id }
      return false unless event_idx

      events[event_idx].dup
    end

    def add(event_params)
      event = Event.new event_params
      if event.valid?
        event.instance_variable_set('@id', next_id)
        events << event
        event.dup
      else
        false
      end
    end

    def update(event_id, event_params)
      event_idx = events.find_index { |event| event.id == event_id }
      return false unless event_idx

      event = events[event_idx].dup
      event.title = event_params[:title]
      if event.valid?
        events[event_idx] = event
        event
      else
        false
      end
    end

    def delete(event_id)
      event_idx = events.find_index { |event| event.id == event_id }
      if event_idx
        event = events[event_idx]
        events.delete_at event_idx
        event.freeze
      else
        false
      end
    end

    private

    def next_id
      @@max_id += 1
    end
  end
end
