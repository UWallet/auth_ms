class WsusersController < ApplicationController
  soap_service namespace: 'urn:WashOutUser', camelize_wsdl: :lower

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
