require_relative 'UserInterface'

fields = [:Name, :Age, :Education, :"College/University", :"Years of experience", :"Last Company"]

user_interface = UserInterface.new
file_formatter = FileFormatLister.new
user_interface.display_intro
user_interface.read_data(fields)
format_list = file_formatter.get_format_files
user_interface.show_formats(format_list)
user_interface.get_choice
path = file_formatter.output_file(user_interface.info, user_interface.choice)
user_interface.show(path)
