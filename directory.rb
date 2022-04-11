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
  puts "1. Input the students".center(50), 
  "2. Show the students".center(50),
  "3. Save the list to students.csv".center(50),
  "4. Load the list from students.csv".center(50),
  "9. Exit".center(50)
end

#takes user input from interactive_menu and makes a choice
def process(selection)
  case selection
    when "1"
      input_students
      puts "Input successful.".center(50)
    when "2"
      show_students
    when "3"
      save_students
      puts "Save successful.".center(50)
    when "4"
      load_students
      puts "Load successful. Press 2 to show list.".center(50)
    when "9"
      puts "You chose: Exit, goodbye!".center(50)
      exit
    else
      puts "I don't know what you meant, try again.".center(50)
  end
end

#enter students into hash within @students list.
def input_students
  puts "Please enter the names of the students".center(50), 
  "To finish, just hit return twice".center(50)

  name = STDIN.gets.chomp

  while !name.empty? do
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students".center(50)

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
  puts "The students of Villains Academy".center(50), 
  "-------------".center(50)
end

#prints list of students from show_students function
def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)".center(50)
  end
end

#prints footer from show_students function
def print_footer
  puts "Overall, we have #{@students.count} great students.".center(50)
end

#saves to .csv file
def save_students
  puts "Please enter file name: "
  @filename = gets.chomp
  file = File.open(@filename, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students (filename=@filename)
  puts "Enter a file name:"
  input = gets.chomp
  if File.exist?(input)
    file = File.open(input, "r")
  else
    file = File.open(filename, "r")
  end
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