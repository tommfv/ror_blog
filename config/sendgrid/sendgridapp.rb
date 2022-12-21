require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: 'nguyen.phu.chau@moneyforward.vn')
to = Email.new(email: 'tommf1595@gmail.com')
subject = 'Sending with SendGrid is Fun'
content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: 'key')
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers