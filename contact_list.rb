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
  else
    puts "no"
  end
end