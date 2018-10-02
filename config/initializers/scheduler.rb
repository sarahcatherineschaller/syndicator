require 'mechanize'

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '1h' do
	@events = Event.all
	@events.each do |event|
		if event.new_record?

			#Yelp
			agent = Mechanize.new 
			page = agent.get("https://www.yelp.com/events/create")
			form = page.forms[0]
			form['Event Name'] = event.name 
			form['When'] = event.date 
			form['What & Why'] = event.description
			form['Business Name'] = event.venue
			form['Price'] = event.price
			page = form.submit 
		
			#Eventbrite
			agent = Mechanize.new 
			page = agent.get("https://www.eventbrite.com/create")
			form = page.forms[0]
			form['Event Title*'] = event.title 
			form['Location'] =  event.venue
			form['Starts'] = event.date 
			form['Event Description'] = event.description 
			page = form.submit

			#Eventseeker
			agent = Mechanize.new 
			page = agent.get("https://eventseeker.com/new-york/ugc-e")
			form = page.forms[0]
			form['Event Name*'] = event.name 
			form['Category*'] = "Community"
			form['Start Date*'] = event.date 
			form['Select City*'] = "New York"
			form['Venue Name*'] = event.venue
			form['Price'] = event.price 
			form['Event Description'] = event.description 
			page = form.submit 

			#Gary's Guide
			agent = Mechanize.new
			page = agent.get("https://www.garysguide.com/events/new?region=newyork")
			form = page.forms[0]
			form['Title'] = event.name
			form['Description'] = event.description
			form['Start Date'] = event.date
			form['Cost'] = event.price
			page = form.submit 

			#Event Crazy
			agent = Mechanize.new
			page = agent.get("https://www.eventcrazy.com/event/submit.cfm")
			form = page.forms[0]
			form['Location Name'] = event.venue
			form['Event Name'] = event.name
			form['Open Date'] = event.date
			form['Description'] = event.description
			page = form.submit 

		end 
	end
end