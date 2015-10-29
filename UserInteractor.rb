require_relative 'FileFormatLister'

class UserInteractor
  def initialize
    @intro_string = <<INTRO
Hi, welcome to the Resume Generator.
Please enter the information asked and we will generate a resume for you in the desired format.
Thank you.
INTRO
    @fields = [:Name, :Age, :Education, :"College/University", :"Years of experience", :"Last Company"]
    @info = Hash.new
  end

  def intro
    puts @intro_string
  end

  def read_data
    @fields.each do |key|
      print key.to_s, ": "
      @info[key] = gets
    end
  end

  def write_to_file
    FileFormatLister.list_formats
    FileFormatLister.make_the_file_work(@info)
  end
end
