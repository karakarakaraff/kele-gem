# Kele
A Ruby Gem API client that allows authorized users to access the [Bloc API](http://docs.blocapi.apiary.io/). Students can get their user and enrollment info, check their mentor’s availability, see their course roadmaps, and even submit their assignments through the command line. This gem also offers the ability to read, send, and receive messages. All data is parsed and neatly formatted into JSON for easy readability.

## Bloc API documentation
To see how the usage examples below work with the Bloc API, be sure to checkout the [full Bloc API documentation](http://docs.blocapi.apiary.io/).

## Getting Started
+ Add `gem kele` into your application's Gemfile and then run `bundle`
+ or run `gem install kele` from your command line.

## Usage example
Run irb and require the gem in your lib:  
```
$ irb
>> require './lib/kele'
=> true
>> kele_client = Kele.new("jane@gmail.com", "abc123")
```

Retreive current user.
```
>> kele_client.get_me
```

List mentor's available timeslots for the current user.
```
>> kele_client.get_me
>> mentor_id = kele_client.user_data["current_enrollment"]["mentor_id"]
>> kele_client.get_mentor_availability(mentor_id)
```

Show a roadmap and associated sections and checkpoints.
```
>> kele_client.get_me
>> roadmap_id = kele_client.user_data["current_enrollment"]["roadmap_id"]
>> kele_client.get_roadmap(roadmap_id)
>> checkpoint_id = # you can find an individual checkpoint id from the get_roadmap data
>> kele_client.get_checkpoint(checkpoint_id)
```

Show message threads for current user, paginated.
```
>> kele_client.get_messages # returns all message threads
>> kele_client.get_messages(1) # returns the first page of message threads (there are 10 threads per page)
```

Create a new message on an existing conversation thread, or a new conversation thread with a message. *Messages without a token will create a new thread.*
```
>> kele_client.create_message(user_id, recipient_id, token, subject, message)
```

Create a checkpoint assignment submission.
```
>> kele_client.create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
```
