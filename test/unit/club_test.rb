require File.dirname(__FILE__) + '/../test_helper'

class ClubTest < ActiveSupport::TestCase
  
  fixtures :clubs
  
  def test_empty
    @club = Club.new
    assert !@club.valid?
    assert @club.errors.invalid?(:name)
    assert @club.errors.invalid?(:description)
    assert @club.errors.invalid?(:official_name)
  end
  
  def test_invalid_duplication
    @club = Club.new( :name => clubs(:WebDev).name,
               :official_name => "Test",
               :description => "Test")
    assert !@club.save
    @club = Club.new( :name => "Testing",
               :official_name => clubs(:WebDev).official_name,
               :description => "Test")
    assert !@club.save
  end
  
  def test_for_truth
    assert true
  end
end
