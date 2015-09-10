require 'target_process'

TargetProcess.configure do |config|
  config.api_url  = "https://oittest.tpondemand.com/api/v1/"
  config.username = "kevin.callahan@maine.gov"
  config.password = "b2AOp7sl"
end

# monkey patch TargetProcess gem to include the Epic entity
TargetProcess.module_eval("class Epic; include TargetProcess::Base; end")