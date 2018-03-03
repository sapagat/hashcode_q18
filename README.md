# Hash Code Online Qualification 2018: Self-Driving Rides

This repository contains the scoring and a possible approach to solve
the Self-Driving rides problem from the Online Qualification Round of Hash
Code 2018.

## Validate output

Arrangements:

- Input file located in the `input` directory with `.in` extension
- Output file **with the same name** in the `output` directory with `.out` extension

Perform validation:

```
bundle exec rake rides:validate
```


## Test

```
bundle exec rspec
```

NOTE: The project is dockerized, so you can execute the stated commands prefixed
 by `docker-compose run --rm app`.
