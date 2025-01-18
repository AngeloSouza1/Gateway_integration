class GatewaysController < ApplicationController
  before_action :set_gateway, only: %i[show edit update destroy]

  def index
    @gateways = Gateway.all
  end

  def show
    # A variável @gateway será definida pelo before_action :set_gateway
  end

  def new
    @gateway = Gateway.new
  end

  def create
    @gateway = Gateway.new(gateway_params)
    if @gateway.save
      redirect_to gateways_path, notice: "Gateway criado com sucesso!"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @gateway.update(gateway_params)
      redirect_to gateways_path, notice: "Gateway atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @gateway.destroy
    redirect_to gateways_path, notice: "Gateway excluído!"
  end

  private

  def set_gateway
    @gateway = Gateway.find(params[:id])
  end

  def gateway_params
    params.require(:gateway).permit(:name, :active, :production_url, :sandbox_url, :public_key, :secret_key, :rate)
  end
end
