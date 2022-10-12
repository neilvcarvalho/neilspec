module Neiltest
  class TestCase
    attr_accessor :results

    Result = Struct.new(:type, :message, :backtrace, :print_backtrace, keyword_init: true) do
      def method_name
        backtrace[0].split(":in `")[1].split("'")[0]
      end

      def fail?
        type == :fail
      end

      def print_backtrace?
        print_backtrace
      end
    end

    def initialize
      self.results = []
      run
    end

    def assert(value, message = nil)
      if value
        add_result Result.new(type: :pass)
      else
        add_result Result.new(type: :fail, backtrace: caller, message: message || "Expected a truthy but got #{value}")
      end
    end

    def refute(value, message = nil)
      if !value
        add_result Result.new(type: :pass)
      else
        add_result Result.new(type: :fail, backtrace: caller, message: message || "Expected a falsy but got #{value}")
      end
    end

    def assert_equal(expected, actual, message = nil)
      if expected == actual
        add_result Result.new(type: :pass)
      else
        add_result Result.new(type: :fail, backtrace: caller, message: message || "Expected #{expected} but got #{actual}")
      end
    end

    def assert_not_equal(first, second, message = nil)
      if first != second
        add_result Result.new(type: :pass)
      else
        add_result Result.new(type: :fail, backtrace: caller, message: message || "Expected #{first} to be different from #{second}")
      end
    end

    private

    def run
      puts "Tests started\n\n"

      public_methods.grep(/^test_/).shuffle.each do |method|
        send(method)
      rescue => e
        add_result Result.new(type: :fail, backtrace: e.backtrace, message: e.message, print_backtrace: true)
      end

      show_failures

      puts "\n\nTests finished"
    end

    def add_result(result)
      results << result

      if result.type == :pass
        print "."
      else
        print "F"
      end
    end

    def show_failures
      puts "\n\nFailures:"

      results.each do |result|
        if result.type == :fail
          puts "#{result.method_name}: #{result.message}"
          puts result.backtrace if result.print_backtrace?
        end
      end
    end
  end
end
