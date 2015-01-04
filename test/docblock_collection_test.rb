require 'test_helper'

class Documentary::DocblockCollectionTest < MiniTest::Test

  test 'dockblocks are split by type' do
    title_block = Documentary::Docblock.new(type: 'title_block')
    resource_block = Documentary::Docblock.new(type: 'resource')
    endpoint_block = Documentary::Docblock.new(type: 'endpoint')
    collection = Documentary::DocblockCollection.new
    collection << title_block << resource_block << endpoint_block
    assert_equal title_block, collection.title_blocks.first
    assert_equal resource_block, collection.resources.first
    assert_equal endpoint_block, collection.endpoints.first
  end

  test 'docblocks are sorted by order' do
    title_block1 = Documentary::Docblock.new(type: 'title_block')
    title_block2 = Documentary::Docblock.new(type: 'title_block', order: 99)
    collection = Documentary::DocblockCollection.new
    collection << title_block1 << title_block2
    assert_equal collection.title_blocks, [title_block2, title_block1]
  end

end