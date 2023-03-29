class InventoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :find_user

  def index
    @inventories = Inventory.where(user: current_user)
  end

  def show
    @inventories = Inventory.find(params[:id])
    @inventory_foods = @inventory.inventory_foods.includes(:food)
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.user = @user
    if @inventory.save
      redirect_to inventory_path(id: @inventory.id), notice: 'Inventory created'
    else
      render :new, alert: 'Error: Inventory not saved'
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory_foods = InventoryFood.where(inventory_id: @inventory.id)
    @inventory_foods.each(&:destroy)
    if @inventory.destroy
      redirect_to inventory_path, notice: 'Inventory deleted'
    else
      flash.now[:alert] = @recipe.errors.full_messages.first if @recipe.errors.any?
      render :index, alert: 'Error: Inventory not deleted'
    end
  end

  private

  def find_user
    @user = current_user
  end

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end
