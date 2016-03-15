require 'pg'

puts 'Connecting to the database...'


class Contacts
  attr_accessor :name, :email, :id, :search_term
  attr_reader :list, :create, :show, :search

  def initialize
    @name = name
    @email = email
    @id = 0
    @contact_id = contact_id
    @search_term = search_term
  end

  def self.conn
    conn = PG.connect(
      host: 'localhost',
      dbname: 'contact_list',
      user: 'development',
      password: 'development')
  end

  def self.list
    p "Here is all of your contacts"
    all_contacts = conn.exec('SELECT * FROM contacts')
    all_contacts.to_a
  end

  def self.create(name, email)
    conn.exec("INSERT INTO contacts (name, email) VALUES ('#{name}', '#{email}')")
  end

  def self.show(id)
    result = conn.exec("SELECT * FROM contacts WHERE contacts.id = #{id};")
    result.to_a
  end

  def self.search(search_term)
    result = conn.exec("SELECT * FROM contacts WHERE contacts.name = '#{search_term}';")
    result.to_a
  end

end


p "Welcome to your contact list tool"
puts

p "Welcome what would you like to do?"

p "list"
p "new"
p "show"
p "search"
puts

selection = gets.chomp
puts

case selection
when "list"
  puts Contacts.list

when "new"
  puts "Enter Name:"
  name = gets.chomp
  puts "Enter E-Mail:"
  email = gets.chomp

  Contacts.create(name, email)

when "show"
  p "What contact # would you like to see?"
  id = gets.chomp
  puts Contacts.show(id)

when "search"
  p "who would you like to search for?"
  search_term = gets.chomp
  puts Contacts.search(search_term)
else
  puts "Sorry no #{selection}"
end
