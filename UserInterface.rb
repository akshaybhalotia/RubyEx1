require_relative 'FileFormatLister'

at_exit {puts "Bye-Bye! See you again"}

class UserInterface
  def initialize
    @file_lister = FileFormatLister.new
    @intro_string = <<INTRO
Hi, welcome to the Resume Generator.
Please enter the information asked and we will generate a resume for you in the desired format.
Thank you.
INTRO
    @fields = [:Name, :Age, :Education, :"College/University", :"Years of experience", :"Last Company"]
    @info = Hash.new
  end

  def display_intro
    puts @intro_string
  end

  def read_data
    @fields.each do |key|
      print key.to_s, ": "
      @info[key] = gets
    end
  end

  def show_formats
    @formats = @file_lister.get_format_files
    unless @formats.count == 0
      @formats.each_with_index {|format, i| puts"#{i+=1}. #{format}"}
    else
      puts 'No formats available'
    end
  end

  def get_choice
    puts "Enter a choice. Press '0' to exit."
    @choice = gets.to_i
    while !((0..@formats.count).include?@choice)
      puts "Wrong choice! Enter a choice again"
      @choice = gets.to_i
    end
  end

  def write_to_file
    @file_lister.output_file(@info, @choice)
    puts "Written successfully to file: #{File.join(__dir__, 'Resume')}.#{@formats[@choice-1].downcase}"
  end
end
