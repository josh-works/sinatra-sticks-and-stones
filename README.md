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

