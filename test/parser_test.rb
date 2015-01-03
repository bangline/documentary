require 'test_helper'

class Documentary::ParserTest < MiniTest::Test

  test 'that docblocks will be collected from a file' do
    file_with_title_block = fetch_fixture('title_block.txt')
    parser = Documentary::Parser.new(file_with_title_block)
    assert_equal 3, parser.docblocks.count
    assert_kind_of Documentary::Docblock, parser.docblocks.first
  end

  test 'invalid docblocks will raise invalid docblock error' do
    file_with_title_block = fetch_fixture('invalid_block.txt')
    assert_raises Documentary::InvalidDocblock do
      Documentary::Parser.new(file_with_title_block)
    end
  end

  test 'invalid docblock errors will have a helpful message' do
    file_with_title_block = fetch_fixture('invalid_block.txt')
    begin
      Documentary::Parser.new(file_with_title_block)
    rescue => e
      assert_includes e.message, 'Invalid docblock YAML in file'
      assert_includes e.message, '/invalid_block.txt:1'
    end
  end

  test 'other exceptions bubble up' do
    assert_raises Errno::ENOENT do
      Documentary::Parser.new('not_there.txt')
    end
  end
end
