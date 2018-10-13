require 'mechanize'

require 'rufus-scheduler'

require 'watir'


scheduler = Rufus::Scheduler.new

scheduler.every '5h' do
	@events = Event.all
	@events.each do |event|
		if event.created_at < 10.days.ago 

			agent = Mechanize.new do |a|
				a.user_agent_alias = 'Mac Safari'
				a.follow_meta_refresh = true
			end

		    #Yelp
		    #visit page
			page = agent.get('https://www.yelp.com/login')

			#form for login
			form = page.form_with(action: '/login')

			#fill out form
			form['email'] = ENV['YELP_EMAIL']
			form['password'] = ENV['YELP_PASSWORD']

			#button
			button = form.button_with(value: 'submit')
			
			#submit form
			form.click_button(button)

			puts page.uri


			
			

			# event_form['Event Title'] = event.name 
			# submit_link = page.link_with(:dom_class => 'btn btn--secondary').click 

			
			# form = page.forms[0]
			# form['Event Title'] = event.name 
			# form['Location'] =  event.venue
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