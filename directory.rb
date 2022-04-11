#instance variable to be accessed by any method
@students = []

#interactive menu to select from process function
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

#prints the menu from interactive_menu
def print_menu
  puts "1. Input the students", 
  "2. Show the students",
  "3. Save the list to students.csv",
  "4. Load the list from students.csv", 
  "9. Exit"
end

#takes user input from interactive_menu and makes a choice
def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again."
  end
end

#enter students into hash within @students list.
def input_students
  puts "Please enter the names of the students", 
  "To finish, just hit return twice"

  name = STDIN.gets.chomp

  while !name.empty? do
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"

    name = STDIN.gets.chomp
  end
end

#prints header, list of students and footer
def show_students
  print_header
  print_students_list
  print_footer
end

#prints header from show_students function
def print_header
  puts "The students of Villains Academy", 
  "-------------"
end

#prints list of students from show_students function
def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

#prints footer from show_students function
def print_footer
  puts "Overall, we have #{@students.count} great students"
end

#saves to .csv file
def save_students
  file = File.open("students.csv", "w")

  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students (filename="students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_loading_students
  filename = ARGV.first
  return if filename.nil?
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_loading_students
interactive_menu