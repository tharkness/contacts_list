require 'csv'
list = CSV.read('list.csv')
# Represents a person in an address book.
class Contact

  attr_accessor :name, :email

  def initialize(name, email)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
  end

  # Provides functionality for managing a list of Contacts in a database.
  class << self

    # Returns an Array of Contacts loaded from the database.
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      i = 0
      CSV.foreach('list.csv') do |row|
        i += 1
        puts "#{i}. #{row[0]} #{row[1]}"
      end
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      new_contact = Contact.new(name, email)
      CSV.open("list.csv", "ab") do |csv|
        csv << [name, email]
      end
      puts "#{new_contact.name}, #{new_contact.email}"
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      CSV.foreach('list.csv') do |csv|
        if Integer($.) == Integer(id)
          puts csv
        end
      end
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      CSV.foreach('list.csv') do |row|
        if (row[0] == term) || (row[1] == term)
          puts "#{row[0]}, #{row[1]}"
        end
      end
    end

  end

end