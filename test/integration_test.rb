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

  test 'the content of the title block is correctly generated' do
    assert_content_for_title_block 'Salutations', "Hello world"
  end

  test 'resources are generated' do
    assert_has_resource_title
  end

  test 'named resources are correctly generated' do
    assert_has_third_level_heading 'A Resource'
  end

  test 'named resources descriptions are correctly generated' do
    assert_content_for_resource 'A Resource', 'This is a resource'
  end

  test 'named resource has table of attributes' do
    assert_table_entry_for_resource 'A Resource', {name: 'email', required: 'true', type: 'string'}
  end

  test 'endpoints are generated' do
    assert_has_enpoints_title
  end

  test 'named enpoints are correctly generated' do

  end
end
