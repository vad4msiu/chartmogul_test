## Instalation
```
bundle install
```

## Usage
```
./bin/runner -h
usage: runner --data FILE_PATH --order FILE_PATH
    --data      JSON with product information
    --order     JSON with order information
    -h, --help
```
## Example
```
./bin/runner --data spec/fixtures/data.json --order spec/fixtures/order.json
10 VS5 $17.98
  2 x 5 $8.99
14 MB11 $54.80
  1 x 8 $24.95
  3 x 2 $9.95
13 CF $25.85
  2 x 5 $9.95
  1 x 3 $5.95
```

## About
This is a problem known as knapsack problem https://en.wikipedia.org/wiki/Knapsack_problem. One of the possible solutions is using dynamic programming. The main algorithm was borrowed from the Internet and tested.

## Assumption
If there no possible packs for order it will raise an error. For example:

| Name | Code | Packs |
| --- | --- | --- |
| Vegemite Scroll | VS5 | 3 @ $6.99 </br> 5 @ $8.99 |

And order
```
2 VS5
```
will raise an error `impossible to pack 2 'Vegemite Scroll'`
