require 'java'
Java::JavaLang::System.set_property "file.encoding","UTF-8"

SIMPLE_NLG_DEFAULT_LEXICON_PATH = Rails.root.join("lib/SimpleNLG/resources/default-lexicon.xml").to_s.freeze
SIMPLE_NLG_PATH                 = Rails.root.join("lib/SimpleNLG").to_s.freeze

Dir["#{SIMPLE_NLG_PATH}/*.jar"].each { |jar| require jar }
