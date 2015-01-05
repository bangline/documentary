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
    assert_includes generated_docs, '### List endpoint'
  end

  test 'enpoint url is generated' do
    assert_includes generated_docs, "```\nGET /some/path\n```"
  end

  test 'endpoint information is correctly generated' do
    assert_includes generated_docs, '* **Authenticated**: true'
    assert_includes generated_docs, '* **Response Formats**: JSON'
  end

  test 'enpoint params are correctly generated' do
    assert_includes generated_docs, 'page | false | The page desired from the set'
    assert_includes generated_docs, 'count | false | The number of results to return'
    assert_includes generated_docs, 'filter | false | The filter for a specific user to find for example: `filter=Testy`'
  end

  test 'enpoint example request is generated' do
    assert_includes generated_docs, "```\nGET /some/path?filter=Testy&page=1&count=3\n```"
  end

  test 'enpoint example response is generated' do
    assert_includes generated_docs, "#### Example Response\n\n```\n"
  end
end
