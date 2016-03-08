require 'csv'

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

  def self.list
    p "Here is all of your contacts"

    CSV.foreach('contacts.csv') do |row|
      puts row.inspect
    end
  end

  def self.create(name, email)
    contact_id = CSV.read('contacts.csv').length + 1
    contact_arr = [contact_id, name, email]

    CSV.open("contacts.csv", "a+") do |csv|
      csv << contact_arr
    end
  end

  def self.show(id)
    CSV.foreach('contacts.csv') do |row|
      if row[0] == id
        puts row.to_s
      end
    end
  end

  def self.search(search_term)
    CSV.foreach('contacts.csv') do |row|
      if row.include?(search_term)
        puts row.to_s
      end
    end
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
