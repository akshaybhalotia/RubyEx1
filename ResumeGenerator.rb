require_relative 'UserInteractor'

resume_generator = UserInteractor.new
resume_generator.intro
resume_generator.read_data
resume_generator.write_to_file
