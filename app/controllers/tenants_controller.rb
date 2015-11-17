class TenantsController < ApplicationController
  before_action :set_tenant
  def edit
  end
  
  def update
    respond_to do |format|
      Tenant.transaction do
        if @tenant.update(tenant_params)
          if @tenant.plan == "premium" && @tenant.payment.blank?
            
            @payment = Payment.new({ email: tenant_params["email"],
              token: params[:payment]["token"],
              tenant: @tenant })
            begin
              @payment.process_payment
              @payment.save
            rescue Exception => e 
              flash[:error] = e.message
              @payment.destroy
              @tenant.plan = "free"
              @tenant.save
              
              redirect_to edit_tenant_path(@tenant) and return
            end
          end
          format.html { redirect_to edit_plan_path, notice: "Plan was successfully updated" }
        else
          format.html { render :edit }
        end
      end
    end
  end
  
  def change
    @tenant = Tenant.find(params[:id])
    Tenant.set_current_tenant @tenant.id
    session[:tenant_id] = Tenant.current_tenant.id
    redirect_to home_index_path, notice: "Switched to organization #{@tenant.name}"
  end
  
  private
  
  def set_tenant
    @tenant = Tenant.find(Tenant.current_tenant_id)
  end
  
  def tenant_params
    params.require(:tenant).permit(:name, :plan)
  end
end