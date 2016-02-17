require 'csv'
require 'pg'
list = CSV.read('list.csv')
# Represents a person in an address book.
class Contact

  attr_accessor :name, :email
  attr_reader :id

  def initialize(name, email, id=nil)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
    @id = id
  end



  def self.connection
    conn = PG.connect(
      host: 'localhost', 
      dbname: 'contacts', 
      user: 'development', 
      password: 'development'
      )
    conn
  end

  # Provides functionality for managing a list of Contacts in a database.
  class << self

    # Returns an Array of Contacts loaded from the database.
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      results = Contact.connection.exec_params("SELECT * FROM contacts;")
      result_process(results)
    end

    def result_process(results)
      contacts = []
      results.each do |contact|
        contacts << Contact.new(contact['name'], contact['email'], contact['id'])
      end
      p contacts
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      Contact.connection.exec_params("INSERT INTO contacts(name, email) VALUES($1, $2);", [name, email])
      Contact.new(name, email)
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      result = Contact.connection.exec_params("SELECT * FROM contacts WHERE id=$1 LIMIT 1;", [id])
      contacto = result[0]
      contino = Contact.new(contacto['name'], contacto['email'], contacto['id'])
      p contino
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      # CSV.foreach('list.csv') do |row|
      #   if (row[0] == term) || (row[1] == term)
      #     puts "#{row[0]}, #{row[1]}"
      #   end
      # end
      result = Contact.connection.exec_params("SELECT * FROM contacts WHERE name=$1 OR email=$1;", [term])
      results = []
      result.each do |contact|
        results << Contact.new(contact['name'], contact['email'], contact['id'])
      end
      p results
    end

  end



  def self.update(name, email, id)
    # if persisted?
    result = Contact.find(id)
    result.name = name
    result.email = email
    Contact.connection.exec_params("UPDATE contacts SET name = $1, email = $2 WHERE id = $3;", [name, email, id])
    result
    # else
      # nil
    # end
  end

  def self.delete(id)
    result = Contact.find(id)
    Contact.connection.exec_params("DELETE FROM contacts WHERE id=$1;", [id])
    result = nil
    Contact.all
  end

  # def persisted?
  #   !id.nil?
  # end

end