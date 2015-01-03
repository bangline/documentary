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

  def assert_has_resource_title
    assert_includes generated_docs, "## Resources"
  end

  def assert_has_third_level_heading(heading)
    assert_includes generated_docs, "### #{heading}"
  end

  def assert_content_for_resource(resource, content)
    assert_match /### #{resource}\n\n#{content}/, generated_docs
  end

  def assert_table_entry_for_resource(resource, row_content)
    assert_match /### #{resource}[.+]#{row_content[:name]} | #{row_content[:required]} | #{row_content[:type]}/, generated_docs
  end
end