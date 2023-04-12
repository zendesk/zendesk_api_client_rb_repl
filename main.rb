require 'pry' # Add breakpoints with `binding.pry`
require 'pry-doc' # Commands: show-doc (?) and show-source ($)

# Navigation while debugging
require 'pry-nav'
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'

require 'httpx'
require 'httpx/adapters/faraday'

require 'zendesk_api'

# You won't need to namespace every resource inside the REPL
module ZendeskAPI
  class Client
    GZIP_EXCEPTIONS = [:httpx]
  end
  # Short for map_ids - A table with ID and the eval'd code you pass
  # Example: mids(client.users.fetch!, :email, :created_at) # [[id, email, created_at]]
  # More helpers at https://gist.github.com/ecoologic/66939216c9b2443ae643d6d114b53fcc
  def self.mids(items, *fields)
    items.map do |item|
      columns = fields.map { |f| eval "item.#{f}" }
      [item.id, *columns]
    end
  end
  # Client configuration
  client = ZendeskAPI::Client.new do |config|
    config.url = "https://#{ENV['ZENDESK_API_CLIENT_RB_SUBDOMAIN']}.zendesk.com/api/v2"
    config.username = ENV['ZENDESK_API_CLIENT_RB_USERNAME']
    config.password = ENV['ZENDESK_API_CLIENT_RB_PASSWORD']
    config.adapter = :httpx
  end
  current_email = client.current_user.email
  client.config.logger.level = :debug
  puts "\n***** #{client.config.url} - #{current_email} *****"

  # ** Fix CI **
  # client.topics.fetch!.map(&:destroy!)
  # # Undeleted identities:
  # client.users.map { |u| is = u.identities.fetch!; is.map &:value }
  # us[5].identities[1].delete

  # ** Things you can call in your REPL **
  # tickets = client.tickets.fetch!
  # client.tickets.create!(
  #   requester: client.current_user,
  #   organization_id: client.organizations.last.id,
  #   subject: "Testing ticket creation",
  #   description: "Use IDs for associations",
  #   tags: ["tmp"],
  # )
  #
  # article_search = client.articles.search(query: 'test')
  # puts article_search.count
  #
  # ticket = Ticket.find(client, id: 163)
  # ticket.update(status: :closed, comment: { public: false, body: 'Closing...' })
  # ticket.save
  #
  # scedule = client.schedules.create(name: "East Coast", time_zone: "Eastern Time (US & Canada)") # OR...
  # scedule = Schedule.create(client, name: "bogus schedule", time_zone: "Brisbane")
  # scedule.update(workweek: { intervals: [{ start_time: 3420, end_time: 3900 }] })
  # scedule.save
  #
  # client.connection.get(full_url)
  # See main.rb for usage suggestions

  all_resources = ObjectSpace.each_object(Class).select { |k| k < Resource }

  binding.pry # ** Your breakpoint **

  puts 'Bye!' # Type `exit` or `CTRL+C` to quit
end
