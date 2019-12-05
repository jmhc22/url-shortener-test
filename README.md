
# James Clark - URL Shortener Test #
## Summary ##

URL shortening app written in Ruby that users can interact with via the command line or with a browser.

## Setup ##

First, clone this repository. Then:

```bash
> bundle install

> bundle exec rspec #to run unit and integration tests
> rackup #to launch the server (visit localhost:/9292)
```
Note: Integration tests by default run using Firefox.

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

## Languages / Frameworks ##

Ruby/Sinatra - felt that a lightweight framework would be most suitable for the requirements of the app. I only created one Class, and in these early stages only creating and viewing the short urls was required (if I had more time I would have potentially looked into edit and delete functionality).

JavaScript/jQuery - keeping the frontend simple I felt jQuery was sufficient to control the app's frontend interaction with the backend api, and to update the page without reloading.

### Approach ###

| Classes    | Methods |
| -------- | ------- |
| UrlShortener  | create_new, saved_urls |

Looking at the example short URL, it contains three letters followed by three numbers. I decided to keep to this layout but to get these letters from the first three consonants of the website name and then have the numbers randomly generated. Three randomly generated letters may have ended up being simpler to program, but I feel that this method provides a slightly better user experience. The short urls are more recognisable and means two links from the same website but for different pages will match in terms of the letters.

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

* Entering a short url that does not exist redirects to the apps main page at '/'.
* 'http://' is added to any inputted urls without either 'http://' or 'https://'. This is policed and completed by the back end, however the input box in the frontend prepopulates with an optional 'http://' for added user experience.  


## Challenges / Future Development ##

* It was difficult to cater and check for every possible URL. Currently websites with fewer than 3 characters in any component of their URL will only generate the number part of the short URL.
* URLs with fewer than 3 consonants in their name do not return the full 6 characters. I could fix this by, rather than the hard coded 3, generating the required number of numbers to make the short URL 6 characters .
* Invalid links can currently be passed through the frontend app and on the command line and a short url will still be created. I would add further checks to the model to check the url has all the correct components to make it valid, or maybe look into testing whether the link actually exists/gives a valid response.
* The way the short url runs at the moment, you could be given by chance the same number meaning a link could be overwritten by a new one from the same website (or similarly named website). I would add a while loop to the short url creator to check whether a short url already exists in the hash's keys before assigning it to a new url.
* Having not worked with Dockerfiles before I did not include them in this test, however I plan to look into and learn how to use them next week after completion our Makers final projects.

## Tests ##

#### Technologies ####
RSpec - used to test the backend model, 7 passing unit tests.

Capybara - used to test the simple frontend, 2 passing integration tests.

SimpleCov - used to ensure high test coverage, 100% test coverage achieved.


#### User Test / Walkthrough ####

After starting the server using rackup (see setup), in another command line window enter curl requests to test for correct responses.

In the walkthrough below, you will likely receive a different number to 000 as part of the returned short URL. Please replace 000 with your returned number in the second curl request:

```
> rackup

> curl localhost:9292 -XPOST -d '{ "url": "http://www.farmdrop.com" }'
{ "short_url": "/frm000", "url": "http://www.farmdrop.com" }


> curl -v localhost:9292/frm000
...
< HTTP/1.1 301 Moved Permanently
...
< Location: http://www.farmdrop.com
...
{ "url": "http://www.farmdrop.com" } (you are redirected to your original url)
```

Leave the server running and visit localhost:9292/ using your web browser, you should see your short URL from the command line displayed on this page along with an input box to create further short URLs. Enter a URL into this box to create more.

Use the short URL in the path to visit your links eg. localhost:9292/frm000. You can also click directly on the displayed links.

Using a different web browser, all previously created links will persist until you restart the server.

## Code ##

DRY - code that is used by multiple places has been extracted into methods.

Single responsibility - for the model and controller, all methods/routes contain three lines or fewer.
