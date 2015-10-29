require_relative 'UserInterface'

resume_generator = UserInterface.new
resume_generator.intro
resume_generator.read_data
resume_generator.write_to_file
