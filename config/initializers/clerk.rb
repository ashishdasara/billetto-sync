Clerk.configure do |c|
  c.publishable_key = Rails.application.credentials.dig(:clerk, :publishable_key).presence
  c.secret_key = Rails.application.credentials.dig(:clerk, :secret_key).presence
  c.logger = Rails.logger
end
