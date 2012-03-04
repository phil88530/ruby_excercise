# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Depot::Application.initialize!

Depot::Application.configure do
	#setup mailer
	config.action_mailer.delivery_method = :smtp
	
	config.action_mailer.smtp_settings = {
		:address				=> "smtp.gmail.com",
		:port 					=> 589,
		:domain					=> "http://depot-bookstore-example.herokuapp.com/",
		:authentication	=> "plain",
		:user_name			=> "phil88530",
		:password				=> "paris1949",
		:enable_starttls_autp	=> true
	}
end
