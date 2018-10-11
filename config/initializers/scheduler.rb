require 'mechanize'

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '2s' do
	@events = Event.all
	@events.each do |event|
		if event.created_at > 5.hours.ago 

			agent = Mechanize.new do |a|
				a.follow_meta_refresh = true
  				a.keep_alive = false
			end


			# #Yelp
			# agent = Mechanize.new 
			# page = agent.get("https://www.yelp.com/events/create")
			# form = page.forms[0]
			# form['Event Name'] = event.name 
			# form['When'] = event.date 
			# form['What & Why'] = event.description
			# form['Business Name'] = event.venue
			# form['Price'] = event.price
			# page = form.submit 
		
			# #Eventbrite
			page = agent.get('https://www.eventbrite.com')
			signin = page.link_with(:text => /Sign In/).click #click sign in button
			
			form = page.forms[0]
			form['email'] = 
			#go to login page
			#fill out username and password
			#click login
			#click create event button

			
			# form = page.forms[0]
			# form['Event Title*'] = event.name 
			# form['Location'] =  event.venue
			# form['Starts'] = event.date 
			# form['Event Description'] = event.description 
			# page = agent.click(page.link_with(:text => /Save/))

			# #Eventseeker
			# agent = Mechanize.new 
			# page = agent.get("https://eventseeker.com/new-york/ugc-e")
			# form = page.forms[0]
			# form['Event Name*'] = event.name 
			# form['Category*'] = "Community"
			# form['Start Date*'] = event.date 
			# form['Select City*'] = "New York"
			# form['Venue Name*'] = event.venue
			# form['Price'] = event.price 
			# form['Event Description'] = event.description 
			# page = form.submit 

			# #Gary's Guide
			# agent = Mechanize.new
			# page = agent.get("https://www.garysguide.com/events/new?region=newyork")
			# form = page.forms[0]
			# form['Title'] = event.name
			# form['Description'] = event.description
			# form['Start Date'] = event.date
			# form['Cost'] = event.price
			# page = form.submit 

			# #Event Crazy
			# agent = Mechanize.new
			# page = agent.get("https://www.eventcrazy.com/event/submit.cfm")
			# form = page.forms[0]
			# form['Location Name'] = event.venue
			# form['Event Name'] = event.name
			# form['Open Date'] = event.date
			# form['Description'] = event.description
			# page = form.submit 

		end 
	end
end