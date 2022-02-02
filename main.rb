require 'pry' # Add breakpoints with `binding.pry`
require 'pry-doc' # Commands: show-doc (?) and show-source ($)

# Navigation while debugging
require 'pry-nav'
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'

require 'zendesk_api'

# You won't need to namespace every resource inside the REPL
module ZendeskAPI
  # Client configuration
  client = ZendeskAPI::Client.new do |config|
    config.url = "https://#{ENV['ZENDESK_API_CLIENT_RB_SUBDOMAIN']}.zendesk.com/api/v2"
    config.username = ENV['ZENDESK_API_CLIENT_RB_USERNAME']
    config.password = ENV['ZENDESK_API_CLIENT_RB_PASSWORD']
  end
  client.config.logger.level = :debug

  # ** Fix CI **
  # client.topics.fetch!.map(&:destroy!)

  # ** Things you can call in your REPL **
  # tickets = client.tickets.fetch!
  #
  # article_search = client.articles.search(query: 'test')
  # puts article_search.count
  #
  # ti = Ticket.find(client, id: 163)
  # ti.update(status: :closed, comment: { public: false, body: 'Closing...' })
  # ti.save

  # sc = client.schedules.create(name: "East Coast", time_zone: "Eastern Time (US & Canada)")
  # OR sc = Schedule.create(client, name: "bogus schedule", time_zone: "Brisbane")
  # sc.update(workweek: { intervals: [{ start_time: 3420, end_time: 3900 }] })
  # sc.save

  # ** REPL utilities **
  all_resources = ObjectSpace.each_object(Class).select { |k| k < Resource }

  # ** This is your breakpoint **
  binding.pry

  puts 'Bye!'
end
