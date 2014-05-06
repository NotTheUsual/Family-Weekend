# Family Weekend Website

Every year, one side of my extended family gets together in a hotel for a weekend to catch up and make sure that we don't lose touch with each other. It's really nice. Being the webby person in the family, I was asked to produce a website, and having just finished a course in web development I thought it would be a nice exercise to see if I'd forgotten anything.

So the first few pages are simply static - everything hardcoded in HAML files (hopefully this will change one day), with a touch of Bootstrappy SASS (the original mockup used Bootstrap - this doesn't, but retains part of that feel). All run on a small Sinatra app. Easy. Not sure I like the bottomless declarations of HAML/SASS, but pretty happy nonetheless. Nothing too strenuous.

## Photos

I decided to add photo uploading. Which turned out to be a bit of a mess. I guess you can't get complacent after all... Anyway, thanks to Carrierwave, you can now upload photos (to S3).

## Users

Users were easier. To ease privacy concerns, you have to log in to see the group photos. You have to log in as an admin to upload them. There's now also a video that's behind the privacy wall as well. 

---

Essentially, this is a nice small project for me to keep my eye in (with Sinatra and TDD, at least). The problems aren't that large yet, and I've got a year before the next meeting to gradually add features, meaning it can be a relaxing weekend project if I need something grounding to clear my head. 