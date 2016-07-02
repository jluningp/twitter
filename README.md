# Project 3 - Twitter

This project is a Twitter client app.

Submitted by: Jeanne Luning Prak

Time spent: 40 hours spent in total

## User Stories

The following **required** functionality is complete:
- [x] User can sign in using OAuth login flow
- [x] The current signed in user will be persisted across restarts
- [x] User can view last 20 tweets from their home timeline
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh to refresh timeline of tweets.
- [x] User can see the relative timestamp for each tweet "8m", "7h"
- [x] Retweeting and favoriting increment the retweet and favorite count.
- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] Compose Page: User can compose a new tweet by tapping on a compose button.
- [x] User can tap the profile image in any tweet to see another user's profile, which contains the user header view (picture and tagline) and a section with the users basic stats (# tweets, # following, # followers)
- [x] User can navigate to view their own profile, which contains the user header view (picture and tagline) and a section with the users basic stats (# tweets, # following, # followers)

The following **optional** features are implemented:
* [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
* [x] User can unfavorite and it decrements the favorite count. 
* [x] User can unretweet and it decrements the favorite count. 
* [x] When composing, there is a countdown for the number of characters remaining for the tweet (out of 140)
* [x] User can reply to any tweet, and replies should are prefixed with the username and the reply_id is set when posting the tweet
* [x] Profile view should include that user's timeline

The following **additional** features are implemented:
- [x] User interface is created entirely in code without using interface builder
- [x] Twitter icons used for retweet, favorite, and reply
- [x] User can view images embeded in posts
- [x] Retweets show icon of original poster with link to timeline
## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/gE5ye8M.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<a href="https://www.youtube.com/watch?v=W7UdBF1ir2M">Link to Video</a>

Video created with QuickTime Player

## Notes

I made this without using interface builder to better learn how to create interfaces programatically, so that when I collaborate on my app with my team, I will be able to use version control without merge conflicts.

## Questions

## Credits

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright 2016 Jeanne Luning Prak

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
