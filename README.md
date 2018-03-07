# Hash Code Online Qualification 2018: Self-Driving Rides

This repository contains the scoring and a possible approach to solve
the Self-Driving rides problem from the Online Qualification Round of Hash
Code 2018.

## Set up

Build the docker image:

```
docker-compose build
```

Set up the example datasets:

- Create `input` and `output` directories in the root of this project
- Copy `examples/a_example.in` to `input/a_example.in`
- Copy `examples/a_example.out` to `output/a_example.out`.

**Notice that the input and output files have the same name with different
extension**


## Score

This will score the simulation based on the formula stated in the PDF. This will
also apply the validations.

```
bundle exec rake rides:score
```

## Plan

You can run a plan as follows:

```
bundle exec rake rides:plan[<name>]
```

The plans are registered in `src/planner`.

The plan record is for `max_journal_score` planner:

```
*************************
Planning dataset c_no_hurry
Still in progress (200000/200000) ...
Still in progress (200000/200000) ...
Validation has passed
{:total_score=>9515851, :rides_pending=>0, :rides_with_bonus=>0}
9515851 points
*************************
Planning dataset a_example
Validation has passed
{:total_score=>10, :rides_pending=>0, :rides_with_bonus=>1}
10 points
*************************
Planning dataset d_metropolis
Still in progress (50000/50000) ...
Still in progress (50000/50000) ...
Validation has passed
{:total_score=>6992759, :rides_pending=>0, :rides_with_bonus=>817}
6992759 points
*************************
Planning dataset e_high_bonus
Validation has passed
{:total_score=>20353532, :rides_pending=>0, :rides_with_bonus=>9074}
20353532 points
*************************
Planning dataset b_should_be_easy
Validation has passed
{:total_score=>175377, :rides_pending=>0, :rides_with_bonus=>228}
175377 points
*************************
Total points: 37037529
```

## Test

```
bundle exec rspec
```

NOTE: The project is dockerized, so you can execute the stated commands prefixed
 by `docker-compose run --rm app`.
