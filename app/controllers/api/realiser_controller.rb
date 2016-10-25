require 'java'

class Api::RealiserController < ApplicationController
  def realise
    reader = java::io::StringReader.new(params[:xml])
    begin
      records = SimpleNLG::XMLRealiser.getRecording(reader)
      output = []
      if records.getRecord.size > 0
        records.getRecord.each do |record|
          output << SimpleNLG::XMLRealiser.realise(record&.getDocument)
        end
      end
      @realisation = output.join("\n").strip
      render plain: @realisation
    ensure
      reader.close
    end
  end
end
