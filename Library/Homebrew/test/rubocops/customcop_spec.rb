require "rubocop"

require_relative "../../extend/string"
require "rubocop/rspec/support"
require_relative "../../rubocops/formula_desc_cop"

describe RuboCop::Cop::Homebrew::FormulaDesc do

  subject(:cop) { described_class.new }

  context "When auditing formula desc" do
    let(:source) do
      <<-EOS.undent
        class Foo < Formula
          url 'http://example.com/foo-1.0.tgz'
        end
      EOS
    end
    let(:expected_offenses) do
      [{
          message: "Formula should have a desc (Description).",
          severity: :convention,
          line: 1,
          column: 0,
          source: source,
      }]
    end
    it "when there is no desc" do
      inspect_source(cop, source)

      expected_offenses.zip(cop.offenses).each do |expected, actual|
        expect_offense(expected, actual)
      end
    end

    def expect_offense(expected, actual)
      expect(actual.message).to eq(expected[:message])
      expect(actual.severity).to eq(expected[:severity])
      expect(actual.line).to eq(expected[:line])
      expect(actual.column).to eq(expected[:column])
      expect(actual.location.source).to eq(expected[:source])
    end
  end
end
