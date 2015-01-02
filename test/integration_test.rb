require 'test_helper'
require 'integration_helper'

class Documentary::IntegrationTest < MiniTest::Test

  setup do
    Documentary::Generator.build([fetch_fixture('kitchen_sink.txt')])
  end

  teardown do
    File.unlink generated_docs_path
  end

  test 'the title blocks are correctly generated' do
    assert_has_title_block_header 'Salutations'
  end

  test 'the content of the title block is added correctly' do
    assert_content_for_title_block 'Salutations', 'Hello world'
  end
end
