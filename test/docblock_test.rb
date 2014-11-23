require 'test_helper'

class Documentary::DocblockTest < MiniTest::Test

  test 'type is stored as a symbol' do
    docblock = Documentary::Docblock.new({type: 'something'})
    assert_equal :something, docblock.type
  end

end

