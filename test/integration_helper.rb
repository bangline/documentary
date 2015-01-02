class Minitest::Test
  def generated_docs_path
    File.expand_path('../../api.md', __FILE__)
  end

  def generated_docs
    File.read generated_docs_path
  end

  def assert_has_title_block_header(title)
    assert_includes generated_docs, "## #{title}"
  end

  def assert_content_for_title_block(title, content)
    assert_match /## #{title}\n\n#{content}/, generated_docs
  end
end