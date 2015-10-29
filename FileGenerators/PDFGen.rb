require 'prawn'

class PDFGen
  def write_to_file(hash)
    Prawn::Document.generate("Resume.pdf") do
      hash.each {|key, value| text "#{key}: #{value}"}
    end
  end
end
