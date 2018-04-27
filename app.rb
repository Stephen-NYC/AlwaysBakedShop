require 'sinatra'
require 'sendgrid-ruby'
include SendGrid

get "/" do

    erb :index
end


get "/cakes" do

    erb :cakes

end

get "/cookies" do

    erb :cookies
end

get "/muffins" do

    erb :muffins
end

get "/contact" do

    erb :contact
end

get "/reply" do

erb :reply

end

post "/reply" do

    from = Email.new(email: 'AlwaysBaked@bakery.com')
    to = Email.new(email: params[:email])
    subject = 'hi ' + params[:name]
    content = Content.new(type: 'text/html', value:
    "<p>Thanks for subscribing to Always Baked Shop. Here is our catalog </p>
    <br>
    <br>
    <br>
    <ul><h3>Cakes</h3>
        <li>Black Forest Cakes ... $24.50</li>
        <li>Chocolate Cakes ... $24.50</li>
        <li>Strawberry Cakes ... $24.50</li>
        <li>Custom Fondant Cakes ... $30.00+</li>
        <li>Classical Cakes ... $30.00+</li>
    </ul>
    <br>
    <ul><h3>Muffins</h3> 
        <li>Apple Crumble Muffins ... $3.50 per muffin</li>
        <li>Morning Glory ... $3.50 muffin</li>
        <li>CBlueberry Muffins ... $3.50 per muffin</li>
        <li>Raspberry Muffins ... $3.50 per muffin</li>
        <li>Chocolate Muffins ... $3.50 per muffin</li>
    </ul>
    <br>
    <ul><h3>Cookies</h3> 
        <li>Oatmeal Raisin Cookies ..... $5.50 per cookie</li>
        <li>Chocolate & Walnut Cookies ..... $5.50 per cookie</li>
        <li>Double Chocolate Cookies ..... $5.50 per cookie</li>
        <li>Peanutbutter & Chocolate Cookies ..... $5.50 per cookie</li>
        <li>Assorted Pack of Cookies ..... $21.00 per pack</li>
    </ul>
    <br>
    <br>
    <p>Always Stay Baked </p>
    "
    )
    mail = Mail.new(from, subject, to, content)
  
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  
    erb :reply
    redirect "/reply"
  end