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

session 1 start: 3:53 
session 1 end: 4:30

session 2 start: 4:42
session 2 end: 4:54

session 3 start: 4:58
session 3 end: 5:18

session 4 start: 9:39p
session 4 end: 9:55p

------------- a few days later ---------
session 5 start: 4:38p
session 5 end: 

Total time thus far: 60 min, across 2 sessions, rapidly moving towards my goal
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


