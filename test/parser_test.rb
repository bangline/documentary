require 'test_helper'

class Documentary::ParserTest < MiniTest::Test

  def fetch_fixture(name)
    File.expand_path("../fixtures/#{name}", __FILE__)
  end

  test 'collecting docblocks' do
    file_with_title_block = fetch_fixture('title_block.txt')
    parser = Documentary::Parser.new(file_with_title_block)
    assert_equal 1, parser.docblocks.count
  end

  test 'parsed docblocks will be kept as docblocks' do
    file_with_title_block = fetch_fixture('title_block.txt')
    parser = Documentary::Parser.new(file_with_title_block)
    assert_kind_of Documentary::Docblock, parser.docblocks.first
  end

end
