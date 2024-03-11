# Build Your Own Git

My solutions to the [Build your own Git course from Code Crafters](https://app.codecrafters.io/courses/git).

## Dependencies

**Cargo make**

```sh
cargo install cargo-make
```

**jq**

See [the jq downloads page](https://jqlang.github.io/jq/download/) for binaries.

Also available on major package managers, including brew:

```sh
brew install jq
```

## How to run the tests

To run all the tests:

```sh
cargo make test
```

To run *up to and including* a specific test stage:

```sh
cargo make test 3
```
