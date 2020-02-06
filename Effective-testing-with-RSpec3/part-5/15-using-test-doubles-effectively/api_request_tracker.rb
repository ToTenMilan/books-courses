#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'metrics_reporter'
require 'endpoint'

class APIRequestTracker
  def process(request)
    endpoint_description = Endpoint.description_of(request)
    reporter = MetricsReporter.new
    reporter.increment("api.requests.#{endpoint_description}")
  end
end

# 1 Expecting a Message on Any Instance ###########
# RSpec.describe APIRequestTracker do
#   let(:request) { Request.new(:get, '/users') }

#   it 'increments the request counter' do
#     # stub method of object, of which subject dependency is hardcoded, via `any_instance_of`
#     expect_any_instance_of(MetricsReporter).to receive(:increment).with(
#       'api.requests.get_users'
#     )
#     ### its a suboptimal design
#     APIRequestTracker.new.process(request)
#   end
# end


# 2 Stubbing a Factory Method #########
RSpec.describe APIRequestTracker do
  let(:request) { Request.new(:get, '/users') }

  it 'increments the request counter' do
    reporter = instance_double(MetricsReporter)
    allow(MetricsReporter).to receive(:new).and_return(reporter) # stub initializer to return mock
    expect(reporter).to receive(:increment).with('api.requests.get_users')
    # awkward test, because of awkward implementation
    APIRequestTracker.new.process(request)
  end
end


# 3 Using the Class as a Partial Double #########
class APIRequestTracker
  def process(request)
    endpoint_description = Endpoint.description_of(request)
    MetricsReporter.increment("api.requests.#{endpoint_description}") # making `increment` a class method
  end
end

RSpec.describe APIRequestTracker do
  let(:request) { Request.new(:get, '/users') }

  it 'increments the request counter' do
    expect(MetricsReporter).to receive(:increment).with( # use class as partial double
      'api.requests.get_users'
    )

    APIRequestTracker.new.process(request)
  end
end
# its ok, but using partial doubles, shoulg be avoided


# 4 Stubbing a constant ###########
RSpec.describe APIRequestTracker do
  let(:request) { Request.new(:get, '/users') }

  it 'increments the request counter' do
    reporter = class_double(MetricsReporter).as_stubbed_const # this will replace class for duration of example
    expect(reporter).to receive(:increment).with('api.requests.get_users')

    APIRequestTracker.new.process(request)
  end
end
# its ok, but APIRequestTracker is still dependant on MetricsReporter. Refactoring to Dependency Injection should be considered


# 5 DEPENDENCY INJECTION
class APIRequestTracker
  def process(request, reporter: MetricsReporter) # simplest DI
    endpoint_description = Endpoint.description_of(request)
    reporter.increment("api.requests.#{endpoint_description}")
  end
end

RSpec.describe APIRequestTracker do
  let(:request) { Request.new(:get, '/users') }

  it 'increments the request counter' do
    reporter = class_double(MetricsReporter)
    expect(reporter).to receive(:increment).with('api.requests.get_users')

    APIRequestTracker.new.process(request, reporter: reporter) # easily inject a double
  end
end
# drawback is repetition, MetricsReporter will need to be passed to every testing scenario


# constructor injection, to pass dependency once, while creating APIRequestTracker
class APIRequestTracker
  def initialize(reporter: MetricsReporter.new)
    @reporter = reporter
  end

  def process(request)
    endpoint_description = Endpoint.description_of(request)
    @reporter.increment("api.requests.#{endpoint_description}")
  end
end

RSpec.describe APIRequestTracker do
  let(:request) { Request.new(:get, '/users') }

  it 'increments the request counter' do
    reporter = class_double(MetricsReporter)
    expect(reporter).to receive(:increment).with('api.requests.get_users')

    APIRequestTracker.new(reporter: reporter).process(request)
  end
end
# best of all


# when constructor isnt available to modify (like often in Rails)
class APIRequestTracker
  attr_writer :reporter
  # notice no initialize method, only setter
  def reporter
    @reporter ||= MetricsReporter.new
  end

  def process(request)
    endpoint_description = Endpoint.description_of(request)
    reporter.increment("api.requests.#{endpoint_description}")
  end
end

RSpec.describe APIRequestTracker do
  let(:request) { Request.new(:get, '/users') }

  it 'increments the request counter' do
    reporter = class_double(MetricsReporter)
    expect(reporter).to receive(:increment).with('api.requests.get_users')

    tracker = APIRequestTracker.new
    tracker.reporter = reporter # set reporter
    tracker.process(request)
  end
end


# Favor Dependency Injection.
# Use most advanced techniques like `_any_instance` only when needed, mostly while refactoring legacy code.
# Ultimately, code should lead to Dependency Injection
