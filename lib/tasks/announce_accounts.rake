namespace :announce_accounts do
  desc "Email is here -> config/email/subject.text, config/email/message.text"
  task :send_email do

   subject = File.read("#{Rails.root}/config/email/subject.text")
   message = File.read("#{Rails.root}/config/email/message.text")

   puts "SUBJECT -> \n#{subject}"
   puts "MESSAGE -> \n#{message}"

   print "\nAre you sure send this email? [yes/no]: "
   result = STDIN.gets.chomp

   return unless result == 'yes'

   sended_emails = []
   Account.select(:email).all.each do |email|
     next if email.nil?
     next if email.empty?
     next if sended_emails.include?(email)

     sended_emails << email

     AccountMailer.announce_account(email, subject, message).deliveer_later
   end
  end
end
