## Installation
```
bundle install
```

## Run
```
./bin/exporter --report-dir examples
```

## Tests
```
bundle exec rspec
```

### Task 1
The number will be any greater or equal than 100. It happens because operator `select` take the random ready channel and it can be `ticker.C` few times until `select` does not choose `stopCh`. To fix it we can prioritise `select` splitting it on two and use `default` case:
```
select {
    case <-stopCh:
        return
    default:
}
select {
    case <-ticker.C:
}
```

### Task 2
I suggest changing the type of `uuid` column from `text` to `uuid` type and create indexes for `external_id`, `uuid`, `another_id`. The last one require because when there will be cascade deleting then it will scan the table for searching `another_id`.

### Task 3

When we use some external API we need to worry about several things. First, it's a rate limit and pool of connections. Second, it's response errors.

With parallel importing, there can be a problem with sending the same request on create/retrieve customers and plans. There can be a performance problem and also a race condition problem. To avoid this we can use a runner with shared memory and mutex for updating this memory from workers. There can be also another solution and it really depends on how many reports we would like to import.
