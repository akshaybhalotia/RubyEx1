class CSVGen
  def self.write_to_file(hash)
    file = File.open("Resume.csv", "w+")
    hash.each do |key, value|
      file << "#{key},#{value}\n"
    end
    file.close
  end
end
