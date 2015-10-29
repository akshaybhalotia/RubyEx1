require 'prawn'

class PDFGen
  FILE_TYPE = 'PDF'
  def self.write_to_file(hash)
    Prawn::Document.generate("Resume.pdf") do
      hash.each {|key, value| text "#{key}: #{value}"}
    end
  end
end
