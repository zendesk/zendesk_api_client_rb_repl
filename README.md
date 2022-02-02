# Zendesk API Client, Ruby REPL

This small project is a REPL to play around with the [Zendesk API gem](https://rubygems.org/gems/zendesk_api).

Bundle, add your test credentials, run it, and you can start investigating the gem. Read [`main.rb comments`](./main.rb) for inspiration.

Don't forget to check [the gem docs](https://github.com/zendesk/zendesk_api_client_rb#readme) and [the API documentation](https://developer.zendesk.com/api-reference).

Many thanks to [the awesome Pry gem](https://rubygems.org/gems/pry) and all its friends.

## Install and Run

```
bundle
ZENDESK_API_CLIENT_RB_SUBDOMAIN='my-company' \
ZENDESK_API_CLIENT_RB_USERNAME='a@b.c' \
ZENDESK_API_CLIENT_RB_PASSWORD='***' \
  bundle exec ruby main.rb
```

If all goes well, you'll get:

```
From: ~/Code/zendesk_api_client_rb_repl/main.rb:44 :

    39:
    40:   # ** REPL utilities **
    41:   all_resources = ObjectSpace.each_object(Class).select { |k| k < Resource }
    42:
    43:   # ** This is your breakpoint **
 => 44:   binding.pry
    45:
    46:   puts 'Bye!'
    47: end

[1] pry(ZendeskAPI)>
```

And this is your REPL, have fun!

## License and Copyright

See [LICENSE](./LICENSE).

Copyright 2022 Zendesk.
