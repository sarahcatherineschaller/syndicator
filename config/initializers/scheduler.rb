require 'mechanize'

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '1h' do 
	Event.all do |event|
		if event.new_record?

			#Eventbrite
			agent = Mechanize.new
			page = agent.get("http://www.eventbrite.com/l/post-events/")
			form = page.forms[0]
			eventbrite_event = page.form_with(page.css('#event_form'))
			eventbrite_event['Event Title'] = event.name 
			eventbrite_event['Location'] = event.venue 
			eventbrite_event['Starts'] = event.date 
			eventbrite_event['Event Description'] = event.description 
			submit_event = page.link_with(:dom_class => "btn btn--epic submit-for-live")
			page = submit_event.click 


			


		end 
	end
end