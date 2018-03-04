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
- Copy `examples/a_example.out` to `examples/a_example.out`.

**Notice that the input and output files have the same name with different
extension**


## Tasks

### Validate

This will check the `.out` files based on the `.in` file.

```
bundle exec rake rides:validate
```

### Score

This will score the simulation based on the formula stated in the PDF.

```
bundle exec rake rides:score
```

## Test

```
bundle exec rspec
```

NOTE: The project is dockerized, so you can execute the stated commands prefixed
 by `docker-compose run --rm app`.
