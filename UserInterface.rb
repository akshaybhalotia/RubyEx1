require_relative 'FileFormatLister'

class UserInterface
  def initialize
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

  def write_to_file
    FileFormatLister.get_format_files
    FileFormatLister.list_formats
    FileFormatLister.output_file(@info)
  end
end
