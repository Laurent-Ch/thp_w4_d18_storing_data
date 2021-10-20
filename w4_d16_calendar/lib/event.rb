require 'time'
class Event
  attr_accessor :start_date, :duration, :title, :attendees

  def initialize(start, duration, title, list)
    # Time variable:
    # Quick template: 2021-10-18 16:00"
    @start_date = Time.parse(start)
    # Integer:
    @duration = (duration * 60)
    # String:
    @title = title
    # Array:
    @attendees = list
  end

  def postpone_24h
    @start_date += (24 * 60 * 60)
  end

  def end_date
    return @start_date + @duration
  end

  def is_past?
    @start_date < Time.now ? true : false
  end

  def is_future?
    !is_past? ? true : false
  end

  def is_soon?
    return false if is_past?
    @start_date < (Time.now + (30 * 60)) ? true : false
  end

  def to_s
    puts "Titre : #{@title}"
    puts "Date de début : #{@start_date}"
    puts "Durée : #{@duration / 60} minutes"
    puts "Invités : #{@attendees}"
  end



end

# Quick object
# meeting = Event.new("2021-10-18 16:00", 30, "codons!", ["truc@machin.com", "bidule@chose.fr"])
