class Minitest::Test
  def assert_has_title_block_header(title)
    assert_includes generated_docs, "## #{title}"
  end

  def assert_content_for_title_block(title, content)
    assert_match /## #{title}\n\n#{content}/, generated_docs
  end
end