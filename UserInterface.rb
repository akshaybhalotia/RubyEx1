require_relative 'FileFormatLister'

at_exit {puts "Bye-Bye! See you again"}

class UserInterface

  attr_reader :info, :choice
  
  def initialize
    @intro_string = <<INTRO
Hi, welcome to the Resume Generator.
Please enter the information asked and we will generate a resume for you in the desired format.
Thank you.
INTRO
  end

  def display_intro
    show(@intro_string)
  end

  def read_data(fields)
    @info = Hash.new
    fields.each do |key|
      print key.to_s, ": "
      @info[key] = gets
    end
  end

  def show_formats(formats)
    @formats = formats
    unless formats.count == 0
      formats.each_with_index {|format, i| puts"#{i+=1}. #{format}"}
    else
      show('No formats available')
    end
  end

  def get_choice
    show("Enter a choice. Press '0' to exit.")
    @choice = gets.to_i
    while !((0..@formats.count).include?@choice)
      show("Wrong choice! Enter a choice again")
      @choice = gets.to_i
    end
  end

  def show(message)
    puts message
  end
end
