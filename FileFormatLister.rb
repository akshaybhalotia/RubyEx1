FILES = Array.new
Dir[File.join(__dir__, 'FileGenerators', '*.rb')].each do |file|
  load file
  class_name = File.basename(file, '.rb')
  klass = Object.const_get(class_name)
  FILES << class_name if (klass.methods(false) + klass.instance_methods - Object.methods).include?(:write_to_file)
end

at_exit {puts "Bye-Bye! See you again"}

class FileFormatLister
  def self.list_formats
    @@valid_formats = Array.new
    FILES.each do |format|
      format.match(/Gen/) {|m| @@valid_formats << m.pre_match}
    end
    unless @@valid_formats.count == 0
      @@valid_formats.each_with_index {|format, i| puts"#{i+=1}. #{format}"}
    else
      puts 'No formats available'
    end
    puts "Enter a choice. Press '0' to exit."
  end

  def self.make_the_file_work(user_hash)
    begin
      @@choice = gets.to_i
      case @@choice
      when 1..@@valid_formats.count
        klass = Object.const_get(@@valid_formats[@@choice-1]+"Gen")
        if klass.instance_methods.include?(:write_to_file)
          obj = klass.new
          obj.write_to_file(user_hash)
        else
          klass.write_to_file(user_hash)
        end
        puts "Written successfully to file: #{File.join(__dir__, 'Resume')}.#{@@valid_formats[@@choice-1].downcase}"
      when 0
        exit
      else
        puts "Wrong choice! Enter a choice again"
      end
    end while @@choice > @@valid_formats.count
  end
end
