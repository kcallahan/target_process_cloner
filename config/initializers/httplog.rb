# config/initializers/httplog.rb
HttpLog.options[:logger] = Rails.logger if Rails.env.development?