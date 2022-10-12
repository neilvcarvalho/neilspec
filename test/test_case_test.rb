require_relative "test_helper"

class TestCaseTest < Neiltest::TestCase
  def test_assert
    assert(true)
  end

  def test_assert_with_false
    assert(false, "This failure is really expected")
  end

  def test_refute
    refute(false)
  end

  def test_refute_with_true
    refute(true, "This failure is really expected")
  end

  def test_assert_equal
    assert_equal(1, 1)
  end

  def test_assert_equal_with_different_values
    assert_equal(1, 2, "This failure is really expected")
  end

  def test_assert_not_equal
    assert_not_equal(1, 2)
  end

  def test_assert_not_equal_with_same_values
    assert_not_equal(1, 1, "This failure is really expected")
  end

  def test_exception_register_as_failure
    raise "This failure is really expected"
  end
end

TestCaseTest.new
