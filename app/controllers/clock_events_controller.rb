$names = [
  'RON', 'ALANA', 'ADAM', 'AHMAD', 'ALEX', 'AMANDA', 'ANTOINETTE', 'ARTHUR',
  'CARMEN', 'CHRISTIAN', 'KALI', 'KIAH', 'KRYSTAL', 'LEILA', 'MICHELLE',
  'NANCY', 'PAM', 'PERRY', 'RIA', 'ROB', 'RUSSELL', 'SAMANTHA', 'SAVANNAH',
  'SHANNON', 'SHAR', 'SPENCER', 'THERESA', 'VICTORIA', 'YICHEN', 'ZEESHAN',
]


class ClockEventsController < ApplicationController
  def index
    @clock_events = ClockEvent.order('time_logged DESC').all
    @avatars = {}
    
    # assigning random avatar differentiator string from $names to each unique
    # user (uniqueness determined currently by name)
    @clock_events.each do |clock_event|
      if not @avatars.key?(clock_event.name)
        @avatars[clock_event.name] = $names[(0..($names.length - 1)).to_a.sample]
      end
    end
  end

  def show
    @clock_event = ClockEvent.find(params[:id])
  end

  def edit
    @clock_event = ClockEvent.find(params[:id])
  end
  
  def new
  end

  def create
    @clock_event = ClockEvent.new(clock_event_params)
    
    if @clock_event.save
      redirect_to clock_events_path
    else
      redirect_to new_clock_event_path
    end
  end

  def update
    @clock_event = ClockEvent.find(params[:id])

    if @clock_event.update(clock_event_params)
      redirect_to clock_events_path
    else
      redirect_to edit_clock_event_path
    end
  end

  def destroy
    @clock_event = ClockEvent.find(params[:id])
    @clock_event.destroy

    redirect_to clock_events_path
  end

  private
    def clock_event_params
      params.require(:clock_event).permit(:name, :time_logged, :clocking_in)
    end
end
