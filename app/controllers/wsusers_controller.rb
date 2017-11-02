class WsusersController < ApplicationController
  soap_service namespace: 'urn:WashOutUser', camelize_wsdl: :lower

  # make case
  soap_action "make",
              :args   => { :firstName => :string, :lastName => :string, :email => :string, :password => :string },
              :return => :boolean
  def make
    operation = User.create(firstName: params[:firstName], lastName: params[:lastName],email: params[:email], password: params[:password])
    render :soap => true
  end

  soap_action "check",
              :args   => { :email => :string},
              :return => :boolean
  def check
    validate = true
    if !(User.exists?(email: params[:email]))
      validate = false
    end
    render :soap => validate
  end
end
