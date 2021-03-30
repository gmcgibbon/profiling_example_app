# Profiling Example App

👋 Hi, this Rails app was made for my RailsConf 2021 talk: Profiling to make your Rails app Faster. I recommend watching it before proceeding.

## Issue 1: Controller

Placing an order is slow in the app. The essence of this problem is that we sometimes need to do things in controllers that take a long time. Active Job allows us to do that by deferring work from the request-response cycle.

The [`controller_fix` branch](../../tree/controller_fix) shows how we can defer payment capture and email confirmation so checkouts can be performed faster. Essentially, we move the contents of the `confirm_order` method in `OrdersController` to a job. We also add Sidekiq and set it as the queue adapter for production, but you can read the [Sidekiq wiki](https://github.com/mperham/sidekiq/wiki/Active-Job) for a deeper dive on that.


## Issue 2: View

The products index is also slow. While it's easy to paginate lists of things, it also doesn't always solve the problem. Lists of complicated business objects that need to fire off multiple SQL queries are very common. For these, we can utilize caching to build pages once, and reuse them later.

The [`view_fix` branch](../../tree/view_fix) shows how we can cache the list of product partials on the product index with a single call to `render`. Rails manages _how_ exactly things are cached, but the TL;DR is that each partial is cached individually and rendered at once. Isn't Rails great?

NOTE: For caching to work in development, you'll need to run `bin/rails dev:cache` to enable caching (and to turn it back off).


## Issue 3: Network Timeout

This is where things get a little more advanced. We fetch shipping rates in an initializer, which talks to a remote server. Similar to the controller issue, we can't control the behaviour of external systems. Initializers like this can be very painful for developers because they slow down boot time.

We could move shipping rate downloads to a job, and run it on a cron schedule. We could alternatively wrap the initializer in a conditional like `if Rails.env.production?`. Instead of introducing a scheduler, or creating environment-specific initializers, we can use `rake` to isolate the workflow and run it whenever we want. This allows us to download new rates in development, or in production when the app deploys.

While we're here, we can also improve the downloading of shipping rates. Streaming the HTTP request and appending to a file helps cut down memory usage and speed up download time. Check out the [`timeout_fix` branch](../../tree/timeout_fix) for the refactored download task.

NOTE: To simulate a shipping rates remote server, you'll need to boot the rack app in [`shipping_service`](shipping_service). You can start the app with `bin/start`, and the Rails app will know how to connect to it (rack binds to `localhost:9292` by default). Also, to profile boot, please use `BOOT_PROFILE=wall` with your commands (eg. `BOOT_PROFILE=wall bin/rails server`). To disable Spring when profiling, use `DISABLE_SPRING=1` (eg. `BOOT_PROFILE=wall DISABLE_SPRING=1 bin/rails server`).


## Issue 4: Code Loading

Another more advanced performance topic is code loading. In the app, we have initializers and monkey patches that reference autoloaded constants. Most of the time, you won't notice when you reference an autoloaded constant early. However, autoloading too many constants, or autoloading a big constant on boot will cause speed problems.

Code loading can be deferred with callbacks. Specifically, Zeitwerk `on_load` hooks, and Active Support `on_load` hooks. Zeitwerk hooks can only be used for Zeitwerk-loaded code (the app, engines, etc.). Active Support hooks fill the gap for Ruby autoloaded core Rails files (Active Record, Action Controller, etc.). Please see the [`code_load_fix` branch](../../tree/code_load_fix) for more concrete examples.

This wasn't mentioned in the talk, but we should also consider non-autoloaded code loading. Primarily from gems in an app's Gemfile. Rails will require gems automatically, but you may only need a gem for a specific purpose. Gemfile groups help with this, but you can take it a step further by using `require: false` in gem definitions. For example, `faker` is solely used for seeding the database, so we require it in the seeds file only.


## Issue 5: Production Profiling

Debugging performance problems is hard. There's an N+1 query on the cart show page, but that's not the point. Even if the problem is obvious, we might be having a bad day, or not have enough information to know where to look. One tool we have at our disposal for these situations is production profiling.

Rack Mini Profiler allows you to opt into profiling with `Rack::MiniProfiler.authorize_request`. Call it anywhere in your controller, and you'll be able to start profiling production pages. Take a look at the [`production_profiling` branch](../../tree/production_profiling) for an example. The branch also has a benchmark script for cart loading, and a fix to the N+1 query on the cart show page.

NOTE: To test this, you can boot the app in production mode locally with `bin/rails server -e production`. Make sure you run `bin/setup` first to prepare your machine.


## Issue 6: Test Profiling

In the talk I mention bonus content, and this is it! The test suite is a little slow. As Rails apps grow, their test suite (hopefully) grows with it. The bigger and more complex an application is, the more tests it should have to verify correctness.

First, we want to enable parallelization. This will distribute tests across worker processes and run them all at once. This reduces our test suite time by ~1 second, but larger suites will see more substantial returns. Parallelization was added in Rails 6.0.

Now that we're parallelizing tests, we notice one of our tests is particularly long. Specifically, the cart update test. Breaking the test up into multiple tests is best practice for multiple reasons:

- We get a more parallelizable test suite.
- We have more readable tests.
- We declare dependencies for each state tested.

Parallelization and test refactoring can be found on the [`test_fix` branch](../../tree/test_fix).

NOTE: To profile test, please use `TEST_PROFILE=wall` with your commands (eg. `TEST_PROFILE=wall bin/rails test`). You can filter cart tests with `bin/rails test -n /should_update_cart/`, or per file with `bin/rails test test/controllers/carts_controller_test.rb`. To avoid receiving multiple profiles from parallel test processes, you can use `PARALLEL_WORKERS=1` (eg. `TEST_PROFILE=wall PARALLEL_WORKERS=1 bin/rails test`).
