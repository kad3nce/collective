# This configuration is for use with Gmail
Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

Merb::Mailer.config = {
  :host   => 'smtp.gmail.com',
  :port   => '587',
  :user   => 'user@gmail.com',
  :pass   => 'pass',
  :auth   => :plain
}