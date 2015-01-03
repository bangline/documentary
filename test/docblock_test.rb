require 'test_helper'

class Documentary::DocblockTest < MiniTest::Test

  test 'type is stored as a symbol' do
    docblock = Documentary::Docblock.new({type: 'something'})
    assert_equal :something, docblock.type
  end

  test 'the order is defaulted if not given' do
    docblock = Documentary::Docblock.new({type: 'something'})
    assert_equal 9999, docblock.order
  end

  test 'the order is set if given' do
    docblock = Documentary::Docblock.new({type: 'something', order: 1})
    assert_equal 1, docblock.order
  end

end

