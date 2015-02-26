module Retryable
  def perform_retry(retry_count = 3, backoff_seconds = 0.25, backoff_multiplier = 2, &block)
    yield
  rescue
    retry_count -= 1
    raise if retry_count < 0
    sleep backoff_seconds
    backoff_seconds *= backoff_multiplier
    retry
  end
end
