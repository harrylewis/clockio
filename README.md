# Clockio README

This README contains information about how to run this on a local machine, 
how to run tests, where a live version can be found, and some information
about this application.

## What is This?

This repository contains a Ruby on Rails web application called Clockio, which
very simply is a minimum viable product/prototype that allows people to create
clock in/out events, view them, and edit them.

## Running Locally

In order to run this locally, the following is required:

+ Ruby (version 2.5.1)
+ Rails (version 5.2.1)
+ PostgreSQL (version 10.5)

After the requirements are met, you can download this repository, navigate to
the root of this project as your current working directory in your terminal
application, and run the following to install the dependencies:

```bash
bundle install
```

After the dependencies have been installed, a PostgreSQL database named 
`myapp_test` should be created, and an instance of PostgreSQL should be
deployed on your local machine. Then, turn the Ruby `models` into PostgreSQL
`tables` by running the following:

```bash
bin/rails db:migrate
```

After the tables have been successfully created, you may start running the
server by executing (from the same working directory):

```bash
bin/rails server
```

After this, the application can be found and used by navigating to
`localhost:3000` in your web browser.

## Running Tests

From the same working directory as was mentioned in the Running Locally
section, you may run tests against the codebase to ensure that everything is
working properly. Run the tests by running the following:

```bash
bin/rails test test/models/clock_event_test.rb
```

## Live Version

A live version of this application can be found at
[https://clockio.herokuapp.com](https://clockio.herokuapp.com)

## Application Information

### Goals

The overall goals of this application were to:

+ Allow a user to create a clock event by specifing a name, clock type
  (in/out), and time
+ Provide all CRUD capabilities
+ Provide a list of all logged clock events

### Assumptions

In order to successfully create a minimum viable product, a few assumptions
were made:

+ There are no database users, therefore to get the total hours worked in a
  given clock in/out shift, the name associated with the events must be
  compared (which is not safe because 2 users may have the same name)
+ There is one table schema, containing clock events
+ This application does not calculate hours worked (because of the above
  mentioned issue)
+ Since clock events are taken when the user logs this information, the user
  will not be able to choose the time logged initially, but can update this
  information by editing later.

### Future Considerations

Some points are made below as future considerations for this application:

+ Include a user schema/table, this allows
  + More reliable calculation of hours worked
  + Allow authentication, which would allow authorized users to edit/delete
    certain clock events
  + Listing users
+ Pagination of clock events on the home page
+ Prohibit the ability to log two events of the same type consecutively by a
  single user

### Browser Support

Currently this web application has only been reliably tested in Chrome (version
69).

### Data Requirements

Some notes are made below about some things to keep in mind regarding the
application data.

#### Clock Event Schema

Each clock event logged in the database will contain the following schema:

+ ID (Primary Key, ~4 Bytes)
+ Name (String[92], Not Null, ~92 Bytes)
+ Clocking In (Boolean, Not Null, ~1 Byte)
+ Time Logged (Datetime, Not Null, ~4 Bytes)
+ Created At (Timestamp, Not Null, ~4 Bytes)
+ Updated At (Timestamp, Not Null, ~4 Bytes)

With this schema, we can see that at a maximum, each clock event logged has the
capability to use a maximum of ~109 bytes of storage.

#### Scalablility Calculations

If we assume that for a period of 3 years, this application amasses
approximately 1M users (in this case, let's consider them teachers who are
logging their hours worked each day). If we assume that each user works
approximately 5/6 of the year, on weekdays only, this works out to ~217
days/year, and ~652 days over 3 years for each user. Assuming that each user
clocks in once and clocks out once a day (2 clock events per day), this means
that over 3 years, each user will log 1304 events, and 1M users will log 1.304B
events, working out to approximately 1.304 GB of storage. Since this is a
relatively small amount of storage to work with, this should not be a huge
concern.

What should be of more concern is the temporal distribution of activity each
day. Most users will clock in around the same time each day (in the morning),
and clock out around the same time each day (at night). This means there will
be a high volume of requests to the application nodes during these points in
the day. If we assume that these 1M users are split across 4 timezones, and
each of these 250K users are split into 5 separate groups (assuming that
morning clock ins vary, and can be allocated into 5 separate time groups, e.g.
8:00 AM, 8:15 AM, 8:30 AM, 8:45 AM, 9:00 AM), then that means that around these
time intervals, there will be approximately 50K users making 50K requests
during a short period of time. We need to make sure the application layer of
the backend can handle this traffic. It would be wise, as more traffic comes
in, to use some form of elastic allocation of application nodes. We could tune
a single application node to handle somewhere around 10K requests/second.
During these peaks hours that were mentioned, a smart elastic service could be
used to spawn these these application nodes up during those times, and spawn
them down when the traffic is less.
