class FileFormatLister

  @@actions = [(lambda { exit })]

  def get_format_files
    find_format_files
    @files.map {|format| format::FILE_TYPE.upcase}
  end

  def find_format_files
    @files = Array.new
    Dir[File.join(__dir__, 'FileGenerators', '*.rb')].each do |file|
      load file
      class_name = File.basename(file, '.rb')
      klass = Object.const_get(class_name)
      @files << klass if (klass.methods(false) - Object.methods).include?(:write_to_file) && klass::FILE_TYPE
    end
  end

  def define_actions
    @files.each do |format|
      action = lambda { |user_hash|
        format.write_to_file(user_hash)
#        puts "Written successfully to file: #{File.join(__dir__, 'Resume')}.#{format::FILE_TYPE.downcase}"
      }
      @@actions << action
    end
  end

  def output_file(info_hash, choice)
    define_actions
    @@actions[choice].call(info_hash)
  end
end
