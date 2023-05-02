class OrderMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    add_attachments
    I18n.with_locale(LANGUAGES.to_h[order.user.language_pref.capitalize].to_sym) { mail to: order.email, subject: 'Pragmatic Store Order Confirmation' }
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end

  def consolidated_email(user)
    @orders = user.orders
    @orders.each do |order|
      @order = order
      add_attachments
    end
    headers['X-SYSTEM-PROCESS-ID'] = Process.pid
    mail to: user.email, subject: 'All Orders Details' if @orders.present?
  end

  private 

  def add_attachments
    @order.line_items.each do |item|
      images = item.product.images
      if(images.attached?)
        attachments.inline[images[0].filename.to_s] =  images[0].download
        if(images.size > 1)
          images.each_with_index do |image, ind|
            attachments[image.filename.to_s] = image.download if ind > 0 
          end
        end
      end
    end
  end
end
