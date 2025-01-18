class Api::V1::Webhook::QuickPay::PaymentsController < ApiController
  skip_before_action :authenticate_request

  def update
    # Lógica do webhook
    render json: { message: 'ok' }
  end
end
