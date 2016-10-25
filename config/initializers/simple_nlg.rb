require 'java'
Java::JavaLang::System.set_property "file.encoding","UTF-8"

SIMPLE_NLG_DEFAULT_LEXICON_PATH = Rails.root.join("lib/SimpleNLG/resources/default-lexicon.xml").to_s.freeze
SIMPLE_NLG_PATH = Rails.root.join("lib/SimpleNLG").to_s.freeze

Dir["#{SIMPLE_NLG_PATH}/*.jar"].each { |jar| require jar }

module SimpleNLG
  %w(
    simplenlg.aggregation
    simplenlg.features
    simplenlg.format.english
    simplenlg.framework
    simplenlg.lexicon
    simplenlg.morphology.english
    simplenlg.orthography.english
    simplenlg.phrasespec
    simplenlg.realiser.english
    simplenlg.syntax.english
    simplenlg.xmlrealiser
    simplenlg.xmlrealiser.wrapper
  ).each { |package| include_package package }

  class NLG
    # use module's imported packages
    def self.const_missing const ; SimpleNLG.const_missing const ; end

    def self.lexicon
      @@lexicon ||= XMLLexicon.new(SIMPLE_NLG_DEFAULT_LEXICON_PATH)
    end

    def self.factory
      @@factory ||= NLGFactory.new(lexicon)
    end

    def self.realiser
      @@realiser ||= Realiser.new(lexicon)
    end
  end
end
