module SidekiqMiddleware
  module Server
    class SilenceTransientErrors
      include Sidekiq::ServerMiddleware
      def call(job_instance, _job_payload, _queue)
        begin
          yield
        rescue => ex
          if transient?(job_instance, ex)
            raise IgnorableExceptionSinceSidekiqWillRetry.new(ex)
          else
            raise
          end
        end
      end

    private

      RETRIABLE_EXCEPTIONS = [
        "BaseServiceWrapper::HTTPError",
      ]

      def transient?(job_instance, ex)
        if ex.class.to_s.in?(RETRIABLE_EXCEPTIONS)
          return true
        end
        job_instance.class.respond_to?(:transient_exceptions) && ex.class.to_s.in?(job_instance.class.transient_exceptions.map(&:to_s))
      end
    end
  end
end
