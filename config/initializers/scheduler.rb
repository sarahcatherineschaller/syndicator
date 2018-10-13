require 'mechanize'

require 'rufus-scheduler'

require 'watir'


scheduler = Rufus::Scheduler.new

scheduler.every '1h' do
	@events = Event.all
	@events.each do |event|
		if event.created_at < 1.hour.ago 

			#Eventbrite
			browser = Watir::Browser.new 
			browser.goto('https://www.eventbrite.com')
			browser.link(text: 'Sign In').click
			browser.input(name: 'email').send_keys(ENV['EVENTBRITE_EMAIL'])
			browser.button(text: 'Get Started').click
			browser.input(name: 'password').send_keys(ENV['EVENTBRITE_PASSWORD'])
			browser.button(text: 'Log In').click
			browser.link(text: 'Create Event').click
			browser.input(name: 'group-details-name').send_keys(event.name)
			browser.button(text: 'Save').click
			browser.close


		
		end 
	end
end