require 'test_helper'

class ClockEventTest < ActiveSupport::TestCase
  test 'name should be between 1 and 92 characters' do
    clock_event = ClockEvent.new({
      name: '',
      clocking_in: true,
      time_logged: DateTime.now
    })
    assert_not clock_event.valid?, 'Clock event valid with no name'

    clock_event = ClockEvent.new({
      name: 'ajsuwjeudutjrjdmckdlamsowksotoroworktofmdoqoekroekrmdndowkdpekrowmdorksorkwmsmfkrmekrmwkmrkrakfh',
      clocking_in: true,
      time_logged: DateTime.now,
    })
    assert_not clock_event.valid?, 'Clock event valid with name longer than 92 characters'
  end
end
