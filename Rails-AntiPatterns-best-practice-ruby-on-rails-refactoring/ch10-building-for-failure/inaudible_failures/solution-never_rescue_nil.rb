# Antipattern
order_number = order.place! rescue nil # is supposed to rescue network errors
if order_number.nil?
  flash[:error] = 'Unable to reach Fulfillment house. Please Try again'
end


class Order < ActiveRecord::Base
  def place!
    fh_order = send_to_fulfillment_house! # WARNING! even if ultimately error from `save!` is swallowed, order will be sent to be fulfilled. Accompanying with flash message, user will probably place many orders!
    self.fulfillment_house_order_number = fh_order.number
    save! # error raised here will also be swallowed by above `rescue nil`
    return fh_order.number
  end
end



# solution - if you want to rescue HTTP errors, rescue only them
HTTP_ERRORS = [
  Timeout::Error, # NOTE: this one dont inherit from `StandardError`, so wont be catched by general `rescue`
  Errno::EINVAL,
  Errno::ECONNRESET,
  EOFError,
  Net::HTTPBadResponse,
  Net::HTTPHeaderSyntaxError,
  Net::ProtocolError]

order_number = order.place! rescue *HTTP_ERRORS # is supposed to rescue network errors
if order_number.nil?
  flash[:error] = 'Unable to reach Fulfillment house. Please Try again'
end
