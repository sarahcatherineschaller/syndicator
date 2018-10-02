require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '5h' do 
	Event.all do |event|
		if event.new_record?
			#syndicate new event to websites
		end 
	end
end