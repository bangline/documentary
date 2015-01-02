require 'test_helper'

class Documentary::IntegrationTest < MiniTest::Test

  setup do
    fetch_fixture 'kitchen_sink.txt'
  end

  test 'the title block is correctly generated' do
  end
end
