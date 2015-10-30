require_relative 'UserInterface'

fields = [:Name, :Age, :Education, :"College/University", :"Years of experience", :"Last Company"]

resume_generator = UserInterface.new
resume_generator.display_intro
resume_generator.read_data(fields)
resume_generator.show_formats
resume_generator.get_choice
resume_generator.write_to_file
