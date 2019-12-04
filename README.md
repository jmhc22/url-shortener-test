
# James Clark - URL Shortener Test #
## Summary ##

URL shortening app written in Ruby that users can interact with via the command line or with a browser.

## Setup ##

First, clone this repository. Then:

```bash
> bundle install

> bundle exec rspec #to run unit and integration tests
> rackup #to launch the server
```

#### Gemfile ####
```ruby
ruby '2.6.3'

gem 'sinatra'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'puma'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
```

## Requirements ##
#### Core ####
* The URLs do not need to persist between restarts, but should be shareable between different clients while the server is running.
* There should be an endpoint that responds to `POST` with a json body containing a URL, which responds with a JSON repsonse of the short url and the orignal URL, as in the following curl example:
```
curl localhost:4000 -XPOST -d '{ "url": "http://www.farmdrop.com" }'
{ "short_url": "/abc123", "url": "http://www.farmdrop.com" }
```
* When you send a GET request to a previously returned URL, it should redirect to the POSTed URL, as shown in the following curl example:
```
curl -v localhost:4000/abc123
...
< HTTP/1.1 301 Moved Permanently
...
< Location: http://www.farmdrop.com
...
{ "url": "http://www.farmdrop.com" }
```

Note: Data stored to memory, there are no databases

#### Additional ####
* I often forget to type "http://" at the start of a URL. It would be nice if this was handled by the application (frontend or backend is up to you).
* We like to see how you approach the problem, so a few git commits with a clear message about what you're doing are better than one git commit with everything in it.
* We like tests. We don't expect a full test suite, but some tests would be nice to see. Its up to you whether thats integration, unit or some other level of testing.
* We'd be very happy to see a Dockerfile to run the project. This by no means a requirement, so don't go reading the Docker docs if you've never worked with it.
* If you'd like to show off your frontend skills, you could create a simple frontend that can create and display shortened URLs without reloading the page.

## Language / Frameworks ##

Ruby

Sinatra

JavaScript/jQuery

### Approach ###

| Classes    | Methods |
| -------- | ------- |
| UrlShortener  | create_new, saved_urls |

Short URLs contain three letters followed by three numbers. The letters are the first three consonants of the website name and the numbers are randomly generated. This makes the short urls recognisable and means two links from the same website but for different pages will be uniform.

```ruby
{
  'frm287' => 'http://www.farmdrop.com', #randomly generated numbers are stubbed in tests
  'ggl353' => 'http://www.google.com',
  'ggl147' => 'http://www.google.com/imghp',
  'fcb229' => 'http://facebook.com', #create_new method works with or without the 'www.'
  'wkp523' => 'http://en.wikipedia.org/wiki/Main_Page'
}
```

#### Edge Cases ####


## Challenges / Future Development ##

## Tests ##

#### Technologies ####

RSpec - unit tests

SimpleCov - used to ensure high test coverage

Capybara - integration tests the frontend


#### Acceptance Criteria ####


## Code ##
