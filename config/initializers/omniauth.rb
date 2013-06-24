module OmniAuth
  module Strategies
   class Identity
     def request_phase
       redirect '/'
     end

     def registration_form
       redirect '/'
     end

     def registration_phase
       redirect '/'
     end
   end
 end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :identity, :fields => [:email], :model => Teacher, on_failed_registration: lambda { |env|
    HomeController.action(:index).call(env)
  }
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}