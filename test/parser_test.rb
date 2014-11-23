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

  test 'parsed docblocks will have correct methods' do
    file_with_title_block = fetch_fixture('title_block.txt')
    parser = Documentary::Parser.new(file_with_title_block)
    assert_equal :title_block, parser.docblocks.first.type
  end

end
