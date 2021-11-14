## Overview

Racing to create a playable version of https://gist.github.com/josh-works/6d23e311e959d0c666c5bbc70a57ed3a#sticks-and-stones-v4-

> We're building your word guessing game!
> 
>     Get a random four-letter word from the dictionary that is already saved on your computer. (try googling ruby get random word from dictionary)
>     Have the user start guessing words. If your random word is four, and they guess loaf, tell them:
> 
> "two correct letters, one in the right spot"
> 
> etc.

timings: 

Day 1: 1 hr

session 1 start: 3:53 
session 1 end: 4:30

session 2 start: 4:42
session 2 end: 4:54

session 3 start: 4:58
session 3 end: 5:18

session 4 start: 9:39p
session 4 end: 9:55p

[a few days pass]

day 2: 1 hr 45min

session 5 start: 4:38p
session 5 end: 5:38p lol to the minute... school of mines library closing now, gotta pack up.

session 6 start: 9:21p
session 6 end: 10:07p


---------------
## Session 1 notes

OK, first commit done. (end of session 0)

Playing looks like this: 

![game](/images/playing-game.jpg)

Lets get this playable on localhost via Sinatra.

I wanna be able to do something like `sinatra run app.rb`, visit `localhost:3000`, and have a form/prompt that I can interact with as if it's a command line interface. 

OK, pausing here. 

I feel rusty w/Sinatra, but am ready to start accepting form data so make the game interactive.

Reading https://learn.co/lessons/sinatra-forms-params-readme-walkthrough to refresh

Once I have that, I'll get it ready for deploying to Heroku. 

------------------

## Session 2 notes

i'm committing after getting http://localhost:4567/food_form working, after skimming https://learn.co/lessons/sinatra-forms-params-readme-walkthrough

If you check out the repo here, do `rerun app.rb`, you'll have something _very basic_


OK, http://localhost:4567/food_form works.

passes submitted form data to the next view, but we'll see if the the ruby object doesn't persist across form submissions, evidenced by the changing object ID.

Now to get to Heroku, I need to consult with my notes:

https://github.com/josh-works/til/blob/main/sinatra/deploy-sinatra-app-to-heroku.md

OK, done: https://guessing-game-2.herokuapp.com/food_form

It is live. Not pretty, but live. This wraps up everything up to commit 5ffe297.

## Session 4 notes

9:39, might only type for a minute or two. I've had about 24 hours from the prior session, and as expected, turned this problem over in my mind. 

What I want to do is something that should be _very_ simple - I want to associate a visitor with a ruby "process", so they can interact with _the same ruby object_ across actions. My language might be wrong. I should be able to write some data to a cookie on the client-side, and... do stuff with that. Here we go.

- [ ] check how to persist a session, or session data, across multiple request/response cycles

2 google queries later, looks like my guess was correct. I'll do some sort of cookie storage:

- https://learn.co/lessons/sinatra-cookies-readme
- https://learn.co/lessons/sinatra-sessions
- https://stackoverflow.com/questions/5693528/how-to-use-sinatra-session
- http://www.getlaura.com/how-to-enable-sessions-with-sinatra/

## Session 5 notes

OK, gonna try to write some code around cookies now.

Ugh. Barely seeing this. I just WIP committed something (to push to heroku) testing https://stackoverflow.com/a/5693760/3210178. 

Feels like I'm kinda setting a cookie, but I thought it would be stored client-side, and... looking at all my cookies on localhost, I cannot find a cookie that I thought I somehow created. 

OK... pushed to heroku, I have the same thing - this "rack:session:cookie", which has a `value` of.... oh, maybe I shoulda looked harder. 

![session](/images/session.jpg)

I expected to see random strings I'd set _in_ the cookie, in the sinatra app, in the cookie data.

```
BAh7CUkiD3Nlc3Npb25faWQGOgZFVG86HVJhY2s6OlNlc3Npb246OlNlc3Npb25JZAY6D0BwdWJsaWNfaWRJIkVlODhlNDcwN2RmNTg1ZjEyMmJiNTlhZWI3OTk2MzFjZjRhNjhhZWMyOGI5OTUwOWI3OWMwNzNkNzRjMjkyNDJhBjsARkkiCWNzcmYGOwBGSSIxK0p5eVVqNjI5KzE4K3U2R1lLNTFjZGN2SnlNRUo2MGV2KzJ1SlhydGlnST0GOwBGSSINdHJhY2tpbmcGOwBGewZJIhRIVFRQX1VTRVJfQUdFTlQGOwBUSSItMWQyZjQ1OTg0NzUyZTY5ZjliYzIxNjM1ZmRkMzFlYmJmNTY3NWFhOQY7AEZJIgZtBjsAVEkiEml0IG1lLCBqampvc2gGOwBU--29979f47f447a998b09377d25e14f53ad14ae9a5
```

I guess this is some "encrypted" representation of something that includes the string "jjjosh", but I'm not really seeing it.

Like... I get it. I _thought_ i knew how cookies worked, but where's the file? Where is it being stored? 

OK, back to localhost. I admit I sorta understand the cookie on the server side:

Stick a pry in, call `session`:

```
> session
=> {"session_id"=>"80ba123d3cc3dfa74810cfaec75baca361e671399faa7e87b234605018c57c6a", 
    "csrf"=>"1Eb3aY0WWsNr1HofafmOQTqS+D0iA3Hp04rrOStjZ4c=", 
    "tracking"=>{
      "HTTP_USER_AGENT"=>"1d2f45984752e69f9bc21635fdd31ebbf5675aa9"}, 
      "m"=>"it me, jjjosh"
    }
```

With the pry in, you can see something looking like a session-ish, with a key/value pair as you set it. `m`, `it me, jjjosh`. 

that CSRF thing is probably the "salt" or key to a hashing algorithm, which will hash a string representation of the above little blob, and store it as some file in a browser. 

Lets look at another request:

```
{"session_id"=>"c233edc32d6cf75cfac88feb96cb63c7e1974257906d9198859f62ffbe4a5e11", "csrf"=>"irf+1tyc/9GHK8DcWe6UztaPam88tqGeLXPMp9KqXGk=", "tracking"=>{"HTTP_USER_AGENT"=>"1d2f45984752e69f9bc21635fdd31ebbf5675aa9"}, "m"=>"it me, jjjosh"}
```

It's a different session ID, and a different CSRF value. 

I keep trying to just view the session in the browser, but if I `puts` session, I get this:

```
"#<Rack::Session::Abstract::PersistedSecure::SecureSessionHash:0x00007f9bd7178d90>"
```

I want to see the data. But `to_json` returns the same thing. `show-method` isn't helping me a lot - I cannot see where this method is defined. To the docs: https://www.rubydoc.info/gems/rack/Rack/Session/Abstract/Persisted

Reading that reminded me of:

```
Rack::Session::Cookie
```


Uuuugh finally got it. Here's the full class. Use firefox/chrome localhost storage inspection tool thingy:

![jacked](/images/jacked.jpg)

ok, finally making it work:

```ruby
require 'sinatra'
require './lib/rgyb_game'
use Rack::Session::Cookie, :key => 'jacked.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'some_secret'

get '/' do  
  session["m"] = "it me, focus"
  redirect '/food'
end

get '/food' do
  
  "
   Ruby:    #{RUBY_VERSION}
   Rack:    #{Rack::VERSION}
   Sinatra: #{Sinatra::VERSION}
   #{session['m'].inspect}
 "
   # session["name"] = "i haz cookie"
   # # session["pages"] << "/food_form"
   # erb :food_form
end
```


## session 6

OK, figured out how to grab the session cookie, setting the key. I went a ways down a rabbit hole of figuring out how to decoded and MITM myself by knowing both the key and the secret, but... not a good use of time.

For now, I can stick data in a cookie. Lets practice sticking multiple things in a cookie.

[...]

Er, went simpler, lets just increment a counter in a cookie

And I've got that working. Committing now: 50fccd3

I now know how to do the game that started this whole thing. 

I'll store in a cookie the random word, and when they submit a guess, I'll store it like:

```ruby
cookie_data: {word_to_guess: "velociraptor",
              guesses: ["house", "location"]}
```

Then, I'll read that data out of the cookie every send/response, send it to a slightly modified function for my game, which will return a message like:

```
3 correct letters, 1 in the right place.

You've guessed two words so far:

"house",
"location"
```

That _could_ be just one more session... 