# Setup

Clone this repo and `cd` into it, then:

## 1. Build the image

Running
```sh
./build.sh
```
produces a new docker image named `php-dev`.

If you want to use another name, run
```sh
export DOCKER_IMAGE=your-image-name
```
before the build.

## 2. Run the repro script

First without valgrind to assert that things work properly:
```sh
./run.sh
```

Then under valgrind to trigger the stack overflow:
```sh
./valgrind.sh
```

## 3. Inspect the valgrind coredump

```sh
./inspect.sh
```