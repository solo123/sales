require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  test "Add Brand" do
    brand = Brand.new
    assert !brand.valid?
    assert brand.errors.invalid?(:short_name)
    assert brand.errors.invalid?(:brand_name)

    brand = Brand.new(
      :short_name => 'b01',
      :brand_name => 'brand 01'
    )
    assert brand.valid?
    assert brand.save

    brand1 = Brand.new(
      :short_name => 'b01',
      :brand_name => 'brand_01'
    )
    assert !brand1.valid?
    assert !brand1.save
    assert_equal "已经被使用" , brand1.errors.on(:short_name)
  end
end
