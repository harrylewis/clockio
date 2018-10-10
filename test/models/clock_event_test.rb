require 'test_helper'

class ClockEventTest < ActiveSupport::TestCase
  test 'name should be between 1 and 92 characters' do
    clock_event = ClockEvent.new({
      name: '',
      clocking_in: true,
      time_logged: DateTime.now,
    })
    assert_not clock_event.valid?, 'Clock event valid with no name'

    clock_event = ClockEvent.new({
      name: 'ajsuwjeudutjrjdmckdlamsowksotoroworktofmdoqoekroekrmdndowkdpekrowmdorksorkwmsmfkrmekrmwkmrkrakfh',
      clocking_in: true,
      time_logged: DateTime.now,
    })
    assert_not clock_event.valid?, 'Clock event valid with name longer than 92 characters'
  end

  test 'clocking_in should be present and should be a boolean' do
    clock_event = ClockEvent.new({
      name: 'name',
      time_logged: DateTime.now,
    })

    assert_not clock_event.valid? 'Clock event valid with no clocking_in'
  end
  
  test 'time_logged should be present and should be a DateTime object' do
    clock_event = ClockEvent.new({
      name: 'name',
      clocking_in: true,
    })

    assert clock_event.valid?, 'New clock event invalid with time_logged generated'

    clock_event = ClockEvent.new({
      name: 'name',
      clocking_in: true,
      time_logged: DateTime.now,
    })
    datetime = clock_event.time_logged
    # simulating an udpate (clock event alreadyb exists)
    clock_event.id = 1
    
    assert clock_event.valid?, 'Update clock event invalid with valid time_logged'
    assert clock_event.time_logged == datetime, 'Clock event validation with time_logged overwrites time_logged'
  end
end
