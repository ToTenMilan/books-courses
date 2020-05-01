# Antipattern
def post_to_facebook_feed(message, action_links)
  facebook_session.user.publish_to(facebook_session.user,
    message: message,
    action_links: action_links
  )
# no error rescuing from external service
end



# solution
def post_to_facebook_feed(message, action_links)
  facebook_session.user.publish_to(facebook_session.user,
    message: message,
    action_links: action_links
  )
rescue *FACEBOOK_ERRORS => e
  HoptoadNotifier.notify(e)
end

FACEBOOK_ERRORS = [
  Facebooker::NonSessionUser,
  Facebooker::Session::SessionExpired,
  # ...
]



# for http requests
HTTP_ERRORS = [
  Timeout::Error, # NOTE: this one dont inherit from `StandardError`, so wont be catched by general `rescue`
  Errno::EINVAL,
  Errno::ECONNRESET,
  EOFError,
  Net::HTTPBadResponse,
  Net::HTTPHeaderSyntaxError,
  Net::ProtocolError]

begin
  # make request
rescue => e
  HoptoadNotifier.notify(e)
end



# rescuing SMTP errors
SMTP_SERVER_ERRORS = [
  Timeout::Error,
  IOError,
  Net::SMTPUnknownError,
  Net::SMTPServerBusy,
  Net::SMTPAuthenticationError
]

SMTP_CLIENT_ERRORS = [
  Net::SMTPFatalError,
  Net::SMTPSyntaxError
]

def notify_of_action(user, action)
  begin
    Mailer.action_notification(user, action).deliver
  rescue *SMTP_CLIENT_ERRORS # notify user
    flash[:warning] = "There was an issue delivering your notification. "\
                      "Please check the notification list settings."
  rescue *SMTP_SERVER_ERRORS # notify developers
    HoptoadNotifier.notify(e)
  end
end



# solution to services with bad documentation
#
# When You dont know what errors could be raised by underlying service
# You should under-rescue it, rather than rescue too much.
# This way, you could monitor raised errors overtime, add them to the list of rescued errors, and handle properly
