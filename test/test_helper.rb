require 'documentary'
require 'minitest/autorun'

# Plagiarized and bastardized from Tilt, they like tests like me. :raised_hands:
# https://github.com/rtomayko/tilt/blob/master/test/test_helper.rb
class Minitest::Test
  def self.setup(&block)
    define_method :setup do
      super(&block)
      instance_eval(&block)
    end
  end

  def self.teardown(&block)
    define_method :teardown do
      instance_eval(&block)
      super(&block)
    end
  end

  def self.test(name, &block)
    define_method(test_name(name), &block)
  end

  def fetch_fixture(name)
    File.expand_path("../fixtures/#{name}", __FILE__)
  end

  private

    def self.test_name(name)
      "test_#{sanitize_name(name).gsub(/\s+/,'_')}".to_sym
    end

    def self.sanitize_name(name)
      name.gsub(/\W+/, ' ').strip
    end
end
