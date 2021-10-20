class User
  attr_accessor :name, :email, :age
  @@all_users = []

  def initialize(user_name, user_email, user_age)
    @name = user_name
    @email = user_email
    @age = user_age
    
    # Putting user variables in a array and storing it within a class variable.
    @user_data = [@name, @email, @age]
    @@all_users << @user_data
    #@@all_users << self.name
  end
  
  # Pour l'appeler, User.all
  def self.all
    return @@all_users
  end

  def self.find_by_email(email)
    @@all_users.each do |i|
      if i[1].include?(email)
        return "L'utilisateur s'appelle #{i[0]} et il/elle a #{i[2]} ans."
      end
    end
    puts "Cet email n'est lié à aucun utilisateur enregistré."
  end
end

