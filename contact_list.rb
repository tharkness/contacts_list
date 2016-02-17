require_relative 'contacts'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  puts "Here is a list of available commands: 
      new    - create a new contact
      list   - List all contacts
      show   - Show a contact
      search - Search contacts"
  command = ARGV[0]
  param = ARGV[1]
  case command
  when "list"
    Contact.all
  when "new"
    puts "Enter full name: "
    name = $stdin.gets.chomp
    puts "Enter email: "
    email = $stdin.gets.chomp
    Contact.create(name, email)
  when "show"
      Contact.find(param)
  when "search"
    puts "Enter name or email of person you are looking for: "
    search_peram = $stdin.gets.chomp
    Contact.search(search_peram)
  when "update"
    puts "Enter name, email to be updated followed by the id of the person to be updated."
    name = $stdin.gets.chomp
    email = $stdin.gets.chomp
    id = $stdin.gets.chomp
    Contact.update(name, email, id)
  when "delete"
    puts "Enter id of contact you wish to delete"
    id = $stdin.gets.chomp
    Contact.delete(id)
  else
    puts "no"
  end
end