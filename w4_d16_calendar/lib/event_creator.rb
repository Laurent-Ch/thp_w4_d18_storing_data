

class EventCreator 
  attr_accessor :event_title, :event_date, :event_duration, :event_attendees

  def initialize
    puts "Salut, tu veux créer un événement ? Cool !" 
    puts "Commençons. Quel est le nom de l'événement ?"
    print '>'
    @event_title = gets.chomp.to_s

    puts "Super. Quand aura-t-il lieu ?"
    print '>'
    # example: 2021-10-19 13:00
    @event_date = gets.chomp.to_s

    puts "Au top. Combien de temps va-t-il durer (en minutes) ?"
    print '>'
    @event_duration = gets.chomp.to_i

    puts "Génial. Qui va participer ? Balance leurs e-mails"
    print '>'
    @event_attendees = gets.chomp.split(',')

    event = Event.new(@event_date, @event_duration, @event_title, @event_attendees).to_s

    puts "Super, c'est noté, ton évènement a été créé !"
  end
end
