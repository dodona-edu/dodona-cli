# Dodona CLI

Commandline interface for Dodona.

[![asciicast](https://asciinema.org/a/uSQMrPzjFCQoxEtin293C7DZ9.png)](https://asciinema.org/a/uSQMrPzjFCQoxEtin293C7DZ9)

## Contributing to dodona-cli
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright © 2017 Ghent University. See LICENSE.txt for
further details.

# Ideas

What should/could be possible with the dodona-cli.

## Exercise flow

How should the general flow be when submitting exercises? There should be a certain state (current course, series and submission) so a user does not have to retype he is working on exercise X of course Y.

### Directories and files
Dodona exercises and solutions will be stored in a directory structure. Proposal:
```
Dodona
├── .dodona.yml
└── Programmeren
    ├── .dodona.yml
    └── Reeks 1
        ├── .dodona.yml
        ├── Echo
        │   ├── .dodona.yml
        │   ├── echo.py
        │   └── .submissions
        │       ├── 234
        │       ├── 238
        │       └── 312
        └── ISBN
            ├── .dodona.yml
            ├── ISBN.py
            └── .submissions
                └── 533
```
Where this directory tree would be stored in `$HOME/Dodona` by default.

#### User config
The configuration file is a yml-file (`$HOME/.dodona.yml` by default) which should store default configuration options which do not change when a user hops between exercises and series. A list of configuration values:
- host (https://dodona.ugent.be)
- token (special API token for the user)
- dodona_dir (`$HOME/Dodona`)
- ...

#### State
The state of a course/series/exercise will be described in a `.dodona.yml` in each corresponding directory. A list of possible values in each kind of directory:

- Global (`$HOME/Dodona/.dodona.yml`)
  - ID of the current user (when this is changed, something is not right)
  - Directory a user was working in
  - Last submission id and path
- Courses (`$HOME/Dodona/$COURSENAME/.dodona.yml`)
  - Cached course information (id, description, year, ...)
  - Last exercise within this course a user was working on
  - Last submission id and path within course
  - Series with deadlines for this course
- Series (`$HOME/Dodona/$COURSENAME/$SERIESNAME/.dodona.yml`)
  - Cached series information (description, deadlines, ...)
- Exercises (`$HOME/Dodona/$COURSENAME/$SERIESNAME/.dodona.yml`)
  - Cached exercise information
  - Solved or not (last submission, last correct submission)
  - List of submission ID's for this exercise

Contents of the exercise directory:
  - Description (as PDF, HTML, ...)
  - A hidden folder which stores past submissions

#### Loose exercises
There could be a special folder called `Exercises` where a user could make his exercises 'for fun'

### Commands

| subcommand | function                                     |
+ ---------- + -------------------------------------------- +
| refresh    | refreshes the current state (download new)   |
| continue   | continues working on where the user left     |
| next       | go to the next exercise                      |
| deadlines  | list all the deadlines                       |
| submit     | creates a new submission                     |
| result     | shows the result of the last submission      |
| edit       | opens the code in the user's `$EDITOR`       |
| run        | runs the code                                |
| reset      | resets the user's code to the boilerplate    |
| progress   | shows the current progress within a course   |
| desc       | shows the description of the exercise        |
| open       | opens the exercise URL in browser            |
| select     | select the next course/series/exercise       |

Example flow:

  1. `dodona continue` user wants to resume work
  2. `dodona desc` user opens the description
  3. `dodona edit` user starts editing the code
  4. `dodona run` user runs the code to check if it works
  5. `dodona submit` user submits his code, the commands exits with the message whether his submission is correct or wrong.
  6. `dodona result` the user wants to view detailed feedback (which cases failed etc.)
  7. `dodona progress` how much exercises are left?
  8. `dodona next` goes to the next exercise

## Features to think about
- Does a user get a notification when there are new exercises to make?
- Instead of token login, use UGent username + password and request a temporary token
- git integration: commit and tag each submission, removes the need for a `.submission` folder
  - course-wide (?)
  - integration with UGent GitHub (automatically create remote)
- code testing & linting before submitting
- offline working:
  - Fall back to cached information when internet is not reachable
  - Queue submissions localy, submit them when online again
- after each command:
  - hint which command to run next ('afford' a new action)
  - show a small status (progress, whether new exercises have arrived, ...)

