require 'abstract_unit'

require 'fixtures/person'
require 'fixtures/street_address'

class ActiveResource::Associations::Builder::HasManyTest < ActiveSupport::TestCase
  def setup
    @klass = ActiveResource::Associations::Builder::HasMany
  end

  def test_validations_for_instance
    object = @klass.new(Person, :street_address, {})
    assert_equal({}, object.send(:validate_options))
  end

  def test_instance_build
    object = @klass.new(Person, :street_address, {})
    Person.expects(:defines_has_many_finder_method).with(kind_of(ActiveResource::Reflection::AssociationReflection))

    reflection = object.build

    assert_kind_of ActiveResource::Reflection::AssociationReflection, reflection
    assert_equal :street_address, reflection.name
    assert_equal StreetAddress, reflection.klass
  end

end
