require 'java'

class Api::RealisersController < ApplicationController
  def create
    reader = java::io::StringReader.new(params[:xml])
    begin
      records = SimpleNLG::XMLRealiser.getRecording(reader)
      output = records.getRecord.map do |record|
        SimpleNLG::XMLRealiser.realise(record&.getDocument)
      end
      @realisation = output.join("\n").strip
      render plain: @realisation
    ensure
      reader.close
    end
  end
end
