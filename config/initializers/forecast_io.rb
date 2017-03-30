ForecastIO.configure do |configuration|
configuration.api_key = Rails.application.secrets.api_key_forecast_io
end