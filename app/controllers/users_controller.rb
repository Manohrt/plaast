class UsersController < ApplicationController
	require 'will_paginate/array'
skip_before_action :check_session, :only=>[:login,:validate_login]

  def user_index
    @user=User.all
    @user=User.new
    @user = User.find(session[:user_id]) 
  end

  def new
    @user=User.new
    @user = User.find(session[:user_id]).name 
  end
      
  def create
    @user=User.new(user_params)
    if @user.save
       flash[:notice] = "Successfully Registered!!!"
       redirect_to :action=> "new"
    else
       flash[:notice] = "Please fill in all of the required fields!!!"
       render "new"
    end
  end

  def user_destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:notice] = "User Deleted Successfully!!!"
    redirect_to :action=>"new"
  end

  def login
    @user=User.new
  end

  def validate_login
    params.permit!
    @user=User.where params[:user]
      if not @user.blank?
        session[:user_id]=@user.first.id
        redirect_to :action=>"dashboard"
      else
        flash[:notice] = "Invalid Username or Password"
        redirect_to root_path
      end
  end

  def logout
    session[:user_id]=nil
	redirect_to root_path
  end

  
  def report_page
	@user=User.new
	@user = User.find(session[:user_id]).name
  end
	   
  def dashboard
	@user=User.new
	@user = User.find(session[:user_id]).name
    @lab = Labour.where('issue_date =?',"02/02/2016")
    @mail = []
    @lab.each do |i|
      pr = ProductionReport.where(:id => i.production_report_id ).pluck(:id,:rejected_nos,:finished_goods_name,:weight_per_item,:total_weight_consumed,:rejected_nos_wt_for_re_grounding)
      pr << Issue.where(:id => i.issue_id).pluck(:chemicals,:rm_issues)
      pr = pr.flatten
      @l = Array.new << i.machine_no <<  i.shift << i.issue_date << pr[2] << pr[6] << pr[3] << i.mould << pr[7] << i.no_of_cavity << i.cycle_time << i.pro_time << i.expected_production << i.total_no_of_items_produced << pr[1]  << pr[5] << pr[4] << i.no_of_mins_idle << i.supervisor_name
      @mail << @l
    end
  end  

  def add_orderSummary
    @user=User.new
    @order_summary=OrderSummary.new
    @user = User.find(session[:user_id]).name
  end

  def get_order
    @order_summary=OrderSummary.new(order_summary_params)
    @order_summary.order_no = params[:order_summary][:order_no].to_i
    if @order_summary.save
      flash[:notice] = "Order Saved Successfully!!!"
      redirect_to :action => "index_orderSummary"
	else
	  flash.now[:notice] = "Order not Saved"
	  render "add_orderSummary"
	end
  end
	 
  def index_orderSummary
    @user = User.new
    @user = User.find(session[:user_id]).name
    if Date.today.month>=4
      @order_summary = OrderSummary.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
    else
      @order_summary = OrderSummary.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
	end
	  @order_summary = @order_summary.paginate(page: params[:page]).per_page(10).order("order_no ASC")
  end
	  
  def show_orderSummary
    @user = User.new
    @user = User.find(session[:user_id]).name
    @order_summary = OrderSummary.find params[:id]
  end

  def edit_orderSummary
    @user = User.new
    @user = User.find(session[:user_id]).name
    @order_summary = OrderSummary.find params[:id]
  end

  def update_orderSummary
    @user = User.new
    @user = User.find(session[:user_id]).name
    @order_summary = OrderSummary.find params[:id]
    if @order_summary.update_attributes(order_summary_params)
       flash[:notice] = "Order Updated Successfully!!!"
       redirect_to :action=> "index_orderSummary"
    else
       render "edit_orderSummary"
    end
  end
	  
  def delete_orderSummary
    @pp = params[:id]
    @v = Issue.where(:order_summary_id => @pp).pluck(:id)
    @c = []
    @c << @v
    @kk1 = @c.flatten
    @v.each do  |i|
      if Labour.exists?(:issue_id => i) then
        Labour.find_by(:issue_id => i).destroy
      end
      if ProductionReport.exists?(:issue_id => i) then
        ProductionReport.find_by(:issue_id => i).destroy
      end
    end
    @v.map { |i| Issue.find(i).destroy }
    OrderSummary.find(@pp).destroy
    flash[:notice] = "Order Deleted Successfully!!!"
    redirect_to :action=>"index_orderSummary"
  end

  def report_order_summary
    @user=User.new
    @user = User.find(session[:user_id]).name
  end
      
  def order_summary_report
    $prpt={}
    @user=User.new
    @user = User.find(session[:user_id]).name
    $oss=params[:order_summary][:intial_date]
    $ose=params[:order_summary][:final_date]
    $osrt=params[:subject]
    $osfd,$oshd=[],[] 
    $osrt.map{|i| $osfd<<i.split("/")[0]}
    $osrt.map{|i| $oshd<<i.split("/")[1]}
    @order_summary=OrderSummary.where(:order_date=>$oss..$ose)#.select(@fl.join(","))
	#$prpt=@order_summary.where(:key => $prt)
    @order_summary1=OrderSummary.order_report_to_csv
    respond_to do |format|
    format.html
    format.csv { send_data @order_summary.order_summary_report_to_csv }
    format.xls { send_data @order_summary.order_summary_report_to_csv(col_sep: "\t") }
    end
  end

  def order_sum_report
    @order_summary=OrderSummary.where(:order_date => $oss..$ose)
    $ohd,$ofd=$oshd,$osfd
  end
=begin	    def order_summary_report
	   @user=User.new
	   @user = User.find(session[:user_id]).name
	    $x=params[:order_summary][:intial_date]
	    $y=params[:order_summary][:final_date]
	     @order_summary=OrderSummary.where(:order_date => $x..$y)
		@order_summary=OrderSummary.order_report_to_csv
		 respond_to do |format|
		 format.html
		 format.csv { send_data @order_summary.order_report_to_csv }
		 format.xls #{ send_data @order_summary.order_report_to_csv(col_sep: "\t") }
		end
	  end

	  def order_sum_report
	      @order_summary=OrderSummary.where(:order_date => $x..$y)
	  end
=end

  def index_orderSummayForIssue
    @user = User.new
    @user = User.find(session[:user_id]).name
    if Date.today.month>=4
      @order_summary = OrderSummary.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
	else
      @order_summary = OrderSummary.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
	end
      @order_summary = @order_summary.paginate(page: params[:page], per_page: 10).order("order_no ASC")
  end


  def index_issuesForProduction
    @user = User.new
    @user = User.find(session[:user_id]).name
      if Date.today.month>=4
        @issue = Issue.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31")).order('issue_slip_no ASC')
	  else
        @issue = Issue.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31")).order('issue_slip_no ASC')
	  end
    #@issue = Issue.all
    @iss = []
    @issue.each do |i|
      unless ProductionReport.exists?(:issue_id=>i.id)
	    @iss << i
	  end
    end
    @issue = @iss.paginate(page: params[:page], per_page: 10)
  end


  def index_productionReport
    @user = User.new
    @user = User.find(session[:user_id]).name
    #@issue = Issue.all
      if Date.today.month>=4
        @issue = Issue.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
	  else
        @issue = Issue.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
	  end
	  if Date.today.month>=4
	    @production_report = ProductionReport.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
	  else
        @production_report = ProductionReport.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
	  end
	@production_report = @production_report.paginate(page: params[:page], per_page: 10).order("issue_slip_no ASC")
  end
	  
  def add_productionReport
    @user = User.new
    @issue = Issue.find(params[:id])
    @o_id = @issue.order_summary_id
    @order_summary = OrderSummary.where("id LIKE '%#{@o_id}%'")
    @cost = Cost.last
    @production_report = ProductionReport.new
    @user = User.find(session[:user_id]).name
  end

  def get_production
    @production_report = ProductionReport.new(production_report_params) 
      if @production_report.save
	    flash[:notice] = "Production Saved Successfully!!!"
        redirect_to :action => "index_productionReport"
      else
	    flash.now[:notice] = "Production not Saved"
	    render "add_productionReport"
	  end
  end

  def edit_productionReport
    @user = User.new
    @user = User.find(session[:user_id]).name
#   @issue = Issue.find(params[:id])
#   @production_report = ProductionReport.find_by ("issue_id LIKE '%#{params[:id]}%'")
    @production_report = ProductionReport.find params[:id]
    @i_id = @production_report.issue_id
    @issue = Issue.find_by("id LIKE '%#{@i_id}%'")
    @o_id = @issue.order_summary_id
    @order_summary = OrderSummary.find_by("id LIKE '%#{@o_id}%'")
    @cost = Cost.last
  end

  def update_productionReport
    @user = User.new
    @user = User.find(session[:user_id]).name
#   @production_report = ProductionReport.find_by ("issue_id LIKE '%#{params[:id]}%'")
    @production_report = ProductionReport.find params[:id]
      if @production_report.update_attributes(production_report_params)
        flash[:notice] = "Production Updated Successfully!!!"
        redirect_to :action=> "index_productionReport"
      else
        render "edit_productionReport"
      end
  end

  def show_productionReport
    @user = User.new
    @user = User.find(session[:user_id]).name
#   @issue = Issue.find(params[:id])
#   @production_report = ProductionReport.find_by ("issue_id LIKE '%#{params[:id]}%'")
    @production_report = ProductionReport.find params[:id]
    @i_id = @production_report.issue_id
    @issue = Issue.where("id LIKE '%#{@i_id}%'")
    @cost = Cost.last
  end

  def delete_productionReport
    pr = params[:id]
    if Labour.exists?(:production_report_id => pr) then
      Labour.find_by(:production_report_id => pr).destroy
    end
    if Finished.exists?(:production_report_id => pr) then
      Finished.find_by(:production_report_id => pr).destroy
    end
    ProductionReport.find(pr).destroy
#   @production_report = ProductionReport.find params[:id]
#   @production_report.destroy
    flash[:notice] = "Production Report Deleted Successfully!!!"
    redirect_to :action=>"index_productionReport"
  end

  def report_production
    @user=User.new
    @user = User.find(session[:user_id]).name
  end

  def productn_report
    @user=User.new
    @user = User.find(session[:user_id]).name
    $prs=params[:production_report][:intial_date]
    $pre=params[:production_report][:final_date]
    $prrt=params[:subject]
    $prfd,$prhd=[],[] 
    $prrt.map{|i| $prfd<<i.split("/")[0]}
    $prrt.map{|i| $prhd<<i.split("/")[1]}
    @iss=$prfd+Issue.column_names
    @prr=$prfd+ProductionReport.column_names
    @is=@iss.select{|i| @iss.count(i) > 1}
    @pr=@prr.select{|i| @prr.count(i) > 1}
    @issue = Issue.where(:issue_date => $prs..$pre)#.select((@is+["id"]).join(','))
    @production_report=ProductionReport.where("date IS '#{$prs..$pre}'")#@issue.select{|i| ProductionReport.where("id IS '#{i.id} AND date IS '#{$prs..$pre}'").select((@pr+["id","issue_id"]).join(','))}
    @prod=@production_report+@issue
    $prod=@prod
    @production_report1=ProductionReport.production_report_to_csv
    respond_to do |format|
	format.html
	format.csv { send_data @production_report.production_report_to_csv }
	format.xls { send_data @production_report.production_report_to_csv(col_sep: "\t") }
	end
  end

	  def product_report
	   @production_report=ProductionReport.where(:date => $prs..$pre)
	   $prod1=$prod
	  end

    def lab_report
      @user=User.new
      @user = User.find(session[:user_id]).name
    end

    def labour_report
	    @user=User.new
	    @user = User.find(session[:user_id]).name
	  $lrs=params[:labour][:intial_date]
    $lre=params[:labour][:final_date]
    $lrrt=params[:subject]
    $lrfd,$lrhd=[],[] 
    $lrrt.map{|i| $lrfd<<i.split("/")[0]}
    $lrrt.map{|i| $lrhd<<i.split("/")[1]}
    @liss=$lrfd+Labour.column_names
    @lrr=$lrfd+ProductionReport.column_names
    @is=@liss.select{|i| @liss.count(i) > 1}
    @lr=@lrr.select{|i| @lrr.count(i) > 1}
    @labour = Labour.where(:issue_date => $lrs..$lre)#.select((@is+["id"]).join(','))
    @production_report=ProductionReport.where(:date=> $lrs..$lre)#@issue.select{|i| ProductionReport.where("id IS '#{i.id} AND date IS '#{$prs..$pre}'").select((@pr+["id","issue_id"]).join(','))}
    @lrod=@labour+@production_report
    $lrod=@lrod
    @labour1=Labour.labour_to_csv
	   	respond_to do |format|
		   format.html
		   format.csv { send_data @labour.labour_to_csv }
		   format.xls #{ send_data @production_report.production_report_to_csv(col_sep: "\t") }
		  end
	  end

	  def report_labour
	   @labour=ProductionReport.where(:date => $lrs..$lre)
    end
	   
	   def add_purchase
	     @user = User.new
	     @purchase = Purchase.new
	     @user = User.find(session[:user_id]).name
	   end

	   def get_purchase
	     @purchase = Purchase.new(purchase_params)
	     if @purchase.save
	       flash[:notice] = "Purchase Saved Successfully!!!"
	       redirect_to :action => "index_purchase"
	     else
	       flash.now[:notice] = "Purchase not Saved"
	       render "add_purchase"
	     end
	   end

	   def index_purchase
	     @user = User.new
	     @user = User.find(session[:user_id]).name
	     if Date.today.month>=4
	    @purchase = Purchase.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
		else
        @purchase = Purchase.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
		end
	     @purchase = @purchase.paginate(page: params[:page], per_page: 10).order("grn_no ASC")
	   end

	   def show_purchase
	     @user = User.new
	     @user = User.find(session[:user_id]).name
	     @purchase = Purchase.find params[:id]
	   end

	   def edit_purchase
	    @user = User.new
	    @user = User.find(session[:user_id]).name
	    @purchase = Purchase.find params[:id]
	  end

	  def update_purchase
	    @user = User.new
	    @user = User.find(session[:user_id]).name
	    @purchase = Purchase.find params[:id]
	    if @purchase.update_attributes(purchase_params)
	       flash[:notice] = "Purchase Updated Successfully!!!"
	       redirect_to :action=> "index_purchase"
	    else
	       render "edit_purchase"
	    end
	  end

	  def delete_purchase
	   @purchase = Purchase.find params[:id]
	   @purchase.destroy
	   flash[:notice] = "Purchase Deleted Successfully!!!"
	   redirect_to :action=>"index_purchase"
	  end

	  def report_purchase
           @user=User.new
           @user = User.find(session[:user_id]).name
          end

	   def purchase_report
	   @user=User.new
	   @user = User.find(session[:user_id]).name
	    $c=params[:purchase][:intial_date]
	    $d=params[:purchase][:final_date]
	    $prt=params[:subject]
           $prfd,$prhd=[],[] 
           $prt.map{|i| $prfd<<i.split("/")[0]}
           $prt.map{|i| $prhd<<i.split("/")[1]}
	    @purchase=Purchase.where(:date=>$c..$d)#.select(@fl.join(","))
	    #$prpt=@purchase.where(:key => $prt)
	      @purchase1=Purchase.purchase_report_to_csv
		respond_to do |format|
		 format.html
		 format.csv { send_data @purchase.purchase_report_to_csv }
		 format.xls { send_data @purchase.purchase_report_to_csv(col_sep: "\t") }
		end
	  end

	  def purchase_sum_report
	   @purchase=Purchase.where(:date => $c..$d)
	   $phd,$pfd=$prhd,$prfd
	  end

=begin	   def purchase_report
	   @user=User.new
	   @user = User.find(session[:user_id]).name
	    $c=params[:purchase][:intial_date]
	    $d=params[:purchase][:final_date]
	    @purchase=Purchase.where(:date => $c..$d)
	      @purchase=Purchase.purchase_report_to_csv
		respond_to do |format|
		 format.html
		 format.csv { send_data @purchase.purchase_report_to_csv }
		 format.xls { send_data @purchase.purchase_report_to_csv(col_sep: "\t") }
		end
	  end

	  def purchase_sum_report
	   @purchase=Purchase.where(:date => $c..$d)
	  end
=end		
	  
	  def add_issues
	    @user = User.new
	    @issue = Issue.new
	    @order_summary = OrderSummary.find params[:id]
	    @user = User.find(session[:user_id]).name
	  end

	  def get_issues
	    @issue = Issue.new(issues_params)
	    if @issue.save
	      flash[:notice] = "Issues Saved Successfully!!!"
	      redirect_to :action => "index_issues"
	    else
	      flash.now[:notice] = "Issues not Saved"
	      render "add_issues"
	    end
	  end

	  def index_issues
	    @user = User.new
	    @user = User.find(session[:user_id]).name
	    if Date.today.month>=4
	    @issue = Issue.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
		else
        @issue = Issue.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
		end
	    @issue = @issue.paginate(page: params[:page], per_page: 10).order("issue_slip_no ASC")
	  end

	  def show_issues
	    @user = User.new
	    @user = User.find(session[:user_id]).name
	    @issue = Issue.find params[:id]
	  end

	  def edit_issues
	    @user = User.new
	    @user = User.find(session[:user_id]).name
	    @issue = Issue.find params[:id]
	  end

	  def update_issues
	    @user = User.new
	    @user = User.find(session[:user_id]).name
	    @issue = Issue.find params[:id]
	    if @issue.update_attributes(issues_params)
	       flash[:notice] = "Issues Updated Successfully!!!"
	       redirect_to :action=> "index_issues"
	    else
	       render "edit_issues"
	    end
	  end

def delete_issues
  pp = params[:id]
  if Labour.exists?(:issue_id => pp) then
    Labour.find_by(:issue_id => pp).destroy
  end
  if ProductionReport.exists?(:issue_id => pp) then
    ProductionReport.find_by(:issue_id => pp).destroy
  end
          if Ireturn.exists?(:issue_id => pp) then
            Ireturn.find_by(:issue_id => pp).destroy
          end

  Issue.find(pp).destroy
#	    @issue = Issue.find params[:id]
#	    @issue.destroy
  flash[:notice] = "Issues Deleted Successfully!!!"
  redirect_to :action=>"index_issues"
end

	  def report_issues
           @user=User.new
           @user = User.find(session[:user_id]).name
      end

	   def issues_report
	   @user=User.new
	   @user = User.find(session[:user_id]).name
	    $iss=params[:issue][:intial_date]
	    $ise=params[:issue][:final_date]
	    $isrt=params[:subject]
           $isfd,$ishd=[],[] 
           $isrt.map{|i| $isfd<<i.split("/")[0]}
           $isrt.map{|i| $ishd<<i.split("/")[1]}
	    @issue=Issue.where(:issue_date=>$iss..$ise)#.select(@fl.join(","))
	    #$prpt=@issue.where(:key => $prt)
	      @issue1=Issue.issue_report_to_csv
		respond_to do |format|
		 format.html
		 format.csv { send_data @issue.issue_report_to_csv }
		 format.xls { send_data @issue.issue_report_to_csv(col_sep: "\t") }
		end
	  end

	  def issue_report
	   @issue=Issue.where(:issue_date => $iss..$ise)
	   $ihd,$ifd=$ishd,$isfd
	  end

=begin	   def issues_report
	    @user=User.new
	   @user = User.find(session[:user_id]).name
	    $a=params[:issue][:intial_date]
	    $b=params[:issue][:final_date]
	    @issue = Issue.where(:issue_date => $a..$b)
	      @issue = Issue.issue_report_to_csv
		respond_to do |format|
		 format.html
		 format.csv { send_data @issue.issue_report_to_csv }
		 format.xls #{ send_data @issue.issue_report_to_csv(col_sep: "\t") }
		end
	  end

	  def issue_report
	   @issue = Issue.where(:issue_date => $a..$b)
=end

          def add_labour
            @user = User.new
        #    @issue = Issue.find params[:id]
            @labour = Labour.new
            @production_report = ProductionReport.find params[:id]
            @i_id = @production_report.issue_id
            @issue = Issue.find_by ("id LIKE '%#{@i_id}%'")
            @o_id = @issue.order_summary_id
            @order_summary = OrderSummary.find_by ("id LIKE '%#{@o_id}%'")
            @user = User.find(session[:user_id]).name
          end

          def get_labour
            @labour = Labour.new(labour_params)
            if @labour.save
              flash[:notice] = "Labour Saved Successfully!!!"
              redirect_to :action => "index_labour"
            else
              flash.now[:notice] = "Labour not Saved"
              render "add_labour"
            end
          end

    def index_productionForLabour
	    @user=User.new
	    @user = User.find(session[:user_id]).name
	    @production = []
	    if Date.today.month>=4
	    @production_report = ProductionReport.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31")).order('issue_slip_no ASC')
		else
        @production_report = ProductionReport.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31")).order('issue_slip_no ASC')
		end
	    #@production_report = ProductionReport.all
	    @production_report.each do |i|
        unless Labour.exists?(:production_report_id => i.id) 
        	@production << i
        end
    	end
	    @production_report = @production.paginate(page: params[:page], per_page: 10)
	end

          def index_labour
            @user=User.new
            @user = User.find(session[:user_id]).name
            if Date.today.month>=4
	    	@labour = Labour.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
			else
        	@labour = Labour.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
			end
#           @issue = Issue.all
#            @production_report = ProductionReport.all
            @labour = @labour.paginate(page: params[:page], per_page: 10).order("issue_slip_no ASC")
          end


          def show_labour
            @user=User.new
            @user = User.find(session[:user_id]).name
            @labour = Labour.find params[:id]
            @i_id = @labour.issue_id
            @issue = Issue.find_by ("id LIKE '%#{@i_id}%'")
#            @o_id = @issue.order_summary_id
#            @order_summary = OrderSummary.find_by("id LIKE '%#{@o_id}%'")
            @production_report = ProductionReport.find_by("issue_id LIKE '%#{@i_id}%'")
          end

          def edit_labour
            @user=User.new
            @user = User.find(session[:user_id]).name
            @labour = Labour.find params[:id]
            @i_id = @labour.issue_id
            @issue = Issue.find_by ("id LIKE '%#{@i_id}%'")
#            @o_id = @issue.order_summary_id
#            @order_summary = OrderSummary.find_by("id LIKE '%#{@o_id}%'")
            @production_report = ProductionReport.find_by("issue_id LIKE '%#{@i_id}%'")
          end


          def update_labour
            @user=User.new
            @user = User.find(session[:user_id]).name
            @labour = Labour.find_by ("production_report_id LIKE '%#{params[:id]}%'")
            if @labour.update_attributes(labour_params)
		       flash[:notice] = "Labour Updated Successfully!!!"
		       redirect_to :action=> "index_labour"
		    else
		       render "edit_labour"
		    end
		  end

		  def delete_labour
		    @labour = Labour.find params[:id]
		    @labour.destroy
		    flash[:notice] = "Labour Deleted Successfully!!!"
		    redirect_to :action=>"index_labour"
		  end



		  def machine_maintenance
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @machine_maintenance = MachineMaintenance.new
		  end

		  def get_machine
		   @machine_maintenance = MachineMaintenance.new(machine_maintenance_params)
		   if @machine_maintenance.save
		     flash[:notice] = "Machine Maintenance Saved"
		     redirect_to :action => "index_machineMaintenance"
		   else
		     flash[:notice] = "Machine Maintenance not Saved"
		     render "machine_maintenance"
		   end
		 end


		def index_machineMaintenance
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		   #@machine_maintenance = MachineMaintenance.all
		   if Date.today.month>=4
			@machine_maintenance = MachineMaintenance.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
				else
			@machine_maintenance = MachineMaintenance.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
				end
		   @machine_maintenance1 = @machine_maintenance.paginate(page: params[:page], per_page: 10).order("created_at DESC")
		 end

		 def edit_machine
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		   @machine_maintenance = MachineMaintenance.find params[:id]
		 end

		 def update_machine
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @machine_maintenance = MachineMaintenance.find params[:id]
		    if @machine_maintenance.update_attributes(machine_maintenance_params)
		     flash[:notice] = "Machine Maintenance Updated"
		     redirect_to :action => "index_machineMaintenance"
		   else
		     flash[:notice] = "Machine Maintenance not updated"
		     render "edit_machine"
		   end
		 end



		 def show_machine
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @machine_maintenance = MachineMaintenance.find params[:id]
		 end

		 def delete_machine
		   @machine_maintenance = MachineMaintenance.find params[:id]
		   if @machine_maintenance.destroy
		     flash[:notice] = "Machine Maintenance Deleted successfully"
		     redirect_to :action => "index_machineMaintenance"
		   else
		     flash[:notice] = "Machine Maintenance not deleted"
		     render "index_machineMaintenance"
		   end
		 end

		 def report_machine_maintenance
		   @user=User.new
		       @user = User.find(session[:user_id]).name 	
		 end

		 def machine_maintenance_report
			@user=User.new
				@user = User.find(session[:user_id]).name
			$mms=params[:machine_maintenance][:intial_date]
			$mme=params[:machine_maintenance][:final_date]
			$mno=params[:machine_maintenance][:mach_no]
			@machine_maintenance = MachineMaintenance.where(:date=>$mms..$mme)
			 end

		 def machine_maintenance_xls_report
			@machine_maintenance = MachineMaintenance.where(:date=>$mms..$mme)
		 end

		  def index_admin 
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @admin=Admin.new
		  end
		  
		  def admin_create
		    @admin=Admin.all
		  end

		  def purchase_type_new
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @purchase_type=TypeOfPurchase.new
		    ff=TypeOfPurchase.all
		   @purchase_type1 = ff.order('LOWER(purchase_type)').reverse
		   @purchase_type1=TypeOfPurchase.all.paginate(page: params[:page], per_page: 10).order("purchase_type ASC")
		  end

		  def purchase_type_create
		    @purchase_type = TypeOfPurchase.find_by(purchase_type_params)
		    if @purchase_type.present?
		      flash[:notice] = "Purchase Type Already Exists!!"
		      redirect_to :action => "purchase_type_new"
		    else
		      @purchase_type = TypeOfPurchase.new(purchase_type_params)
		      if @purchase_type.save
			flash[:notice] = "Purchase Type Saved Successfully!!"
			redirect_to :action => "purchase_type_new"
		      else
			flash[:notice] = "Purchase Type Already Exists"
			redirect_to :action => "purchase_type_new"
		      end
		    end
		  end

		  def purchase_type_delete
		   @purchase_type = TypeOfPurchase.find params[:id]
		   @purchase_type.delete
		   flash[:notice] = "Purchase Type Deleted Successfully!!!"
		   redirect_to :action=>"purchase_type_new"
		  end

		  def insert_material_new
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @insert_material=InsertMaterial.new
		    ff=InsertMaterial.all
		   @insert_material1 = ff.order('LOWER(insert_material_list)').reverse
		   @insert_material1=InsertMaterial.all.paginate(page: params[:page], per_page: 10).order(" insert_material_list ASC")
		  end

		  def insert_material_create
		    @insert_material = InsertMaterial.find_by(insert_material_params)
		    if @insert_material.present?
		      flash[:notice] = "Insert Material Type Already Exists!!"
		      redirect_to :action => "insert_material_new"
		    else
		      @insert_material = InsertMaterial.new(insert_material_params)
		      if @insert_material.save
			flash[:notice] = "Insert Material Type Saved Successfully!!"
			redirect_to :action => "insert_material_new"
		      else
			flash[:notice] = "Insert Material Type Already Exists"
			redirect_to :action => "insert_material_new"
		      end
		    end
		  end

		  def insert_material_delete
		   @insert_material = InsertMaterial.find params[:id]
		   @insert_material.delete
		   flash[:notice] = "Insert Material Type Deleted Successfully!!!"
		   redirect_to :action=>"insert_material_new"
		  end

		 
		  def chemical_type_new
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @chemical_type=ChemicalType.new
		    ff=ChemicalType.all
		   @chemical_type1 = ff.order('LOWER(chemical_type_list)').reverse
		   @chemical_type1=ChemicalType.all.paginate(page: params[:page], per_page: 10).order("chemical_type_list ASC")
		  end
		  
		  def chemical_type_create
		    @chemical_type = ChemicalType.find_by(chemical_type_params)
		    if @chemical_type.present?
		      flash[:notice] = "Chemical Type Already Exists!!"
		      redirect_to :action => "chemical_type_new"
		    else
		      @chemical_type = ChemicalType.new(chemical_type_params)
		      if @chemical_type.save
			flash[:notice] = "Chemical Type Saved Successfully!!"
			redirect_to :action => "chemical_type_new"
		      else
			flash[:notice] = "Chemical Type Already Exists"
			redirect_to :action => "chemical_type_new"
		      end
		    end
		  end
		 
		  def chemical_type_delete
		   @chemical_type = ChemicalType.find params[:id]
		   @chemical_type.delete
		   flash[:notice] = "Chemical Type Deleted Successfully!!!"
		   redirect_to :action=>"chemical_type_new"
		  end
		  
		 def party_order_new
		   @user=User.new
		    @user = User.find(session[:user_id]).name
		    @party_order=PartyOrder.new
		    ff=PartyOrder.all
		     @party_order1= ff.order('LOWER(party_order_list)')
		   @party_order1= PartyOrder.paginate(page: params[:page], per_page: 10).order("party_order_list ASC")
		 end
		  
		 def party_order_create
		    @party_order = PartyOrder.find_by(party_order_params)
		    if @party_order.present?
		       flash[:success] = "Party Already Exists"
		       redirect_to :action => "party_order_new"
		    else
		       @party_order  = PartyOrder.new(party_order_params)
		       if @party_order.save
			 flash[:success] = "Party Saved"
			 redirect_to :action => "party_order_new"
		       else
			 flash[:success] = "Party Already Exists"
			 redirect_to :action => "party_order_new"
		       end
		    end
		  end
		 
		  def party_order_delete
		    @party_order = PartyOrder.find params[:id]
		   @party_order.delete
		   flash[:notice] = "Party Order Deleted Successfully!!!"
		   redirect_to :action=>"party_order_new"
		  end
		  
		  def party_purchase_new 
		     @user=User.new
		    @user = User.find(session[:user_id]).name
		@party_purchase=PartyPurchase.new
		    ff=PartyPurchase.all
		    @party_purchase1 = ff.order('LOWER(party_purchase_list)')
		   @party_purchase1 =PartyPurchase.paginate(page: params[:page], per_page: 10).order("party_purchase_list ASC")
		  end
		   
		   def party_purchse_create
		    @party_purchase = PartyPurchase.find_by(party_purchase_params)
		    if @party_purchase.present?
		       flash[:success] = "Party Already Exists"
		       redirect_to :action => "party_purchase_new"
		    else
		       @party_purchase  = PartyPurchase.new(party_purchase_params)
		       if @party_purchase.save
			 flash[:success] = "Party Saved"
			 redirect_to :action => "party_purchase_new"
		       else
			 flash[:success] = "Party Already Exists"
			 redirect_to :action => "party_purchase_new"
		       end
		    end
		  end

		   def party_purchse_delete
		    @party_purchase = PartyPurchase.find params[:id]
		   @party_purchase.delete
		   flash[:notice] = "Party Purchase Deleted Successfully!!!"
		   redirect_to :action=>"party_purchase_new"
		  end


		  def reground_new
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @reground=Reground.new
		     ff=Reground.all
		     @reground1 = ff.order('LOWER(reground_list)')
		  @reground1 = Reground.paginate(page: params[:page], per_page: 10).order("reground_list ASC")
		  end

		  def reground_create
		    @reground = Reground.find_by(reground_params)
		    if @reground.present?
		       flash[:success] = "Reground Already Exists"
		       redirect_to :action => "reground_new"
		    else
		       @reground  = Reground.new(reground_params)
		       if @reground.save
			 flash[:success] = "Reground Saved"
			 redirect_to :action => "reground_new"
		       else
			 flash[:success] = "Reground Already Exists"
			 redirect_to :action => "reground_new"
		       end
		      end
		    end

		   def reground_delete
		    @reground = Reground.find params[:id]
		   @reground.delete
		   flash[:notice] = "Reground Deleted Successfully!!!"
		   redirect_to :action=>"reground_new"
		  end
		 


		  def chemical_new 
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @chemical=Chemical.new
		     ff=Chemical.all
		     @chemical1 = ff.order('LOWER(chemical_list)')
		  @chemical1 = Chemical.paginate(page: params[:page], per_page: 10).order(" chemical_list ASC")
		  end
		 
		  def chemical_create
		    @chemical = Chemical.find_by(chemical_params)
		    if @chemical.present?
		       flash[:success] = "Chemical Already Exists"
		       redirect_to :action => "chemical_new"
		    else
		       @chemical  = Chemical.new(chemical_params)
		       if @chemical.save
			 flash[:success] = "Chemical Saved"
			 redirect_to :action => "chemical_new"
		       else
			 flash[:success] = "Chemical Already Exists"
			 redirect_to :action => "chemical_new"
		       end
		      end
		    end

		   def chemical_delete
		    @chemical = Chemical.find params[:id]
		   @chemical.delete
		   flash[:notice] = "Chemical Deleted Successfully!!!"
		   redirect_to :action=>"chemical_new"
		  end

		    def raw_material_new 
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		   @raw_material=RawMaterial.new
		   ff=RawMaterial.all
		    @raw_material1=ff.order('LOWER(raw_material_list)')
		    @raw_material1 =RawMaterial.paginate(page: params[:page], per_page: 10).order("raw_material_list ASC")
		    end
		    
		   def raw_create
		   @raw_material = RawMaterial.find_by(ra_material_params)
		    if @raw_material.present?
		       flash[:success] = "Raw Material Already Exists"
		       redirect_to :action => "raw_material_new"
		    else
		       @raw_material  = RawMaterial.new(ra_material_params)
		       if @raw_material.save
			 flash[:success] = "Raw Material Saved"
			 redirect_to :action => "raw_material_new"
		       else
			 flash[:success] = "Raw Material Already Exists"
			 redirect_to :action => "raw_material_new"
		       end
		     end
		    end 
		 
		   def raw_delete
		    @raw_material = RawMaterial.find params[:id]
		   @raw_material.delete
		   flash[:notice] = "Raw Material Deleted Successfully!!!"
		   redirect_to :action=>"raw_material_new"
		  end
		  
	def rejection_reason_new 
		@user=User.new
		@user = User.find(session[:user_id]).name
		@rejection_reason=RejectionReason.new
		ff=RejectionReason.all
		@rejection_reason1=ff.order('LOWER(rejection_reason_time_list)')
		@rejection_reason1 =RejectionReason.paginate(page: params[:page], per_page: 10).order("rejection_reason_list ASC")
	end

	def rejection_reason_create
	  @rejection_reason = RejectionReason.find_by( rejection_reason_params)
	  if @rejection_reason.present?
		flash[:success] = "Rejection Reason Already Exists"
	    redirect_to :action => "rejection_reason_new"
	   else
		@rejection_reason  = RejectionReason.new( rejection_reason_params)
		if @rejection_reason.save
			flash[:success] = "Rejection Reason Saved"
			redirect_to :action => "rejection_reason_new"
		else
			flash[:success] = "Rejection Reason Already Exists"
		    redirect_to :action => "rejection_reason_new"
		end
	end
	end

	def rejection_reason_delete
	   @rejection_reason = RejectionReason.find params[:id]
	   @rejection_reason.delete
	   flash[:notice] = "Rejection Reason Deleted Successfully!!!"
	   redirect_to :action=>"rejection_reason_new"
	end


		  def reason_for_idle_new 
		 @user=User.new
		    @user = User.find(session[:user_id]).name
		     @reason_for_idle_time=ReasonForIdleTime.new
		    ff=ReasonForIdleTime.all
		    @reason_for_idle_time1=ff.order('LOWER(reason_for_idle_time_list)')
		    @reason_for_idle_time1 =ReasonForIdleTime.paginate(page: params[:page], per_page: 10).order("reason_for_idle_time_list ASC")
		  end

		   def reasonforidle_create
		     @reason_for_idle_time = ReasonForIdleTime.find_by( reasonidle_params)
		    if @reason_for_idle_time.present?
		       flash[:success] = "ReasonForIdleTime Already Exists"
		       redirect_to :action => "reason_for_idle_new"
		    else
			@reason_for_idle_time  = ReasonForIdleTime.new( reasonidle_params)
		       if @reason_for_idle_time.save
			 flash[:success] = "ReasonForIdleTime Saved"
			 redirect_to :action => "reason_for_idle_new"
		       else
			 flash[:success] = "ReasonForIdleTime Already Exists"
			 redirect_to :action => "reason_for_idle_new"
		       end
		    end
		  end
		   
		  def reasonforidle_delete
		    @reason_for_idle_time = ReasonForIdleTime.find params[:id]
		   @reason_for_idle_time.delete
		   flash[:notice] = "Reason For Idle Time Deleted Successfully!!!"
		   redirect_to :action=>"reason_for_idle_new"
		  end

		     def nature_new 
		   @user=User.new
		    @user = User.find(session[:user_id]).name
		   @nature_of_work=NatureOfWork.new
		   ff=NatureOfWork.all
		  @nature_of_work1=ff.order('LOWER(nature_of_work_list)')
		   @nature_of_work1 =NatureOfWork.paginate(page: params[:page], per_page: 10).order("nature_of_work_list ASC")
		   end   

		  def nature_create
		    @nature_of_work = NatureOfWork.find_by(nature_params)
		    if  @nature_of_work.present?
		       flash[:success] = "Nature Already Exists"
		       redirect_to :action => "nature_new"
		    else
			@nature_of_work  = NatureOfWork.new(nature_params)
		       if  @nature_of_work.save
			 flash[:success] = "Nature Saved"
			 redirect_to :action => "nature_new"
		       else
			 flash[:success] = "Nature Already Exists"
			 redirect_to :action => "nature_new"
		       end
		    end
		  end 

		 
		  def nature_delete
		    @nature_of_work = NatureOfWork.find params[:id]
		   @nature_of_work.delete
		   flash[:notice] = "Nature Of Work Deleted Successfully!!!"
		   redirect_to :action=>"nature_new"
		  end

		   
		   def goods_new
		 @user=User.new
		    @user = User.find(session[:user_id]).name
		     @finished_goods_name=FinishedGoodsName.new
		    ff=FinishedGoodsName.all
		   # @finished_goods_name1=FinishedGoodsName.order_by('finished_goods_name_list ASC').collect{|x|[x.finished_goods_name_list,x.id]}
		      @finished_goods_name1=ff.order('LOWER(finished_goods_name_list)')

		    @finished_goods_name1 =FinishedGoodsName.paginate(page: params[:page], per_page: 10).order("finished_goods_name_list ASC")  
		   end

		   def goods_create
		     @finished_goods_name = FinishedGoodsName.find_by(goods_params)
		    if @finished_goods_name.present?
		       flash[:success] = "Finished Goods Name Already Exists"
		       redirect_to :action => "goods_new"
		    else
			@finished_goods_name  = FinishedGoodsName.new(goods_params)
		       if @finished_goods_name.save
			 flash[:success] = "Finished Goods Name Saved"
			 redirect_to :action => "goods_new"
		       else
			 flash[:success] = "Finished Goods Name Already Exists"
			 redirect_to :action => "goods_new"
		       end
		    end
		  end


		  def goods_delete
		    @finished_goods_name = FinishedGoodsName.find params[:id]
		   @finished_goods_name.delete
		   flash[:notice] = "Finished Goods Name Deleted Successfully!!!"
		   redirect_to :action=>"goods_new"
		  end
		 
		  def mach_use_new
		 @user=User.new
		    @user = User.find(session[:user_id]).name
		     @machine_used=MachineUsed.new
		    @machine_used1=MachineUsed.all
		  @machine_used1 =MachineUsed.paginate(page: params[:page], per_page: 10).order("created_at DESC")
		  end

		  def machine_use_create
		    @machine_used= MachineUsed.find_by(machine_use_params)
		    if  @machine_used.present?
		       flash[:success] = "Machine Used Already Exists"
		       redirect_to :action => "mach_use_new"
		    else
			@machine_used = MachineUsed.new(machine_use_params)
		       if  @machine_used.save
			 flash[:success] = "Machine Used Saved"
			 redirect_to :action => "mach_use_new"
		       else
			 flash[:success] = "Machine Used Already Exists"
			 redirect_to :action => "mach_use_new"
		       end
		    end
		  end

		 
		  def machine_use_delete
		   @machine_used = MachineUsed.find params[:id]
		   @machine_used.delete
		   flash[:notice] = "Machine Used Deleted Successfully!!!"
		   redirect_to :action=>"mach_use_new"
		  end

		  def mould_new
		 @user=User.new
		    @user = User.find(session[:user_id]).name
		   @mould_no=MouldNo.new
		   @mould_no1=MouldNo.all
		  @mould_no1=MouldNo.paginate(page: params[:page], per_page: 10).order("mould_no_list ASC")

		  end

		  def mould_create
		    @mould_no= MouldNo.find_by(mould_params)
		    if  @mould_no.present?
		       flash[:success] = "MouldNo Already Exists"
		       redirect_to :action => "mould_new"
		    else
			@mould_no = MouldNo.new(mould_params)
		       if  @mould_no.save
			 flash[:success] = "MouldNo Saved"
			 redirect_to :action => "mould_new"
		       else
			 flash[:success] = "MouldNo Already Exists"
			 redirect_to :action => "mould_new"
		       end
		    end
		  end    
		 
		  def mould_delete
		    @mould_no =MouldNo.find params[:id]
		    @mould_no.delete
		    flash[:notice] = "Mould No Deleted Successfully!!!"
		    redirect_to :action=>"mould_new"
		  end
		  
		  def cost_new
		    @user = User.new
		    @user = User.find(session[:user_id]).name
		    @cost = Cost.new
		    @cost1 = Cost.last
		  end

		 def update_cost
		    @cost = Cost.new(cost_params)
		    Cost.last.delete
		    if @cost.save
		      flash[:notice] = "Cost Changed"
		      redirect_to :action => "cost_new"
		    else
		      flash[:notice] = "Cost not changed"
		      render "cost_new"
		    end
		  end



		def supervisor_name
		 @user=User.new
		    @user = User.find(session[:user_id]).name
		   @name_of_supervisor=NameOfSupervisor.new
		   @name_of_supervisor1=NameOfSupervisor.all
		  @name_of_supervisor1=NameOfSupervisor.paginate(page: params[:page], per_page: 10).order("created_at DESC")

		  end

		  def supervisor_create
		    @name_of_supervisor= NameOfSupervisor.find_by(supervisor_params)
		    if  @name_of_supervisor.present?
		       flash[:success] = "Supervisor Already Exists"
		       redirect_to :action => "supervisor_name"
		    else
			@name_of_supervisor = NameOfSupervisor.new(supervisor_params)
		       if  @name_of_supervisor.save
			 flash[:success] = "Supervisor Saved"
			 redirect_to :action => "supervisor_name"
		       else
			 flash[:success] = "Supervisor Already Exists"
			 redirect_to :action => "supervisor_name"
		       end
		    end
		  end

		  def supervisor_delete
		    @name_of_supervisor = NameOfSupervisor.find params[:id]
		    @name_of_supervisor.delete
		    flash[:notice] = "Supervisor Deleted Successfully!!!"
		    redirect_to :action=>"supervisor_name"
		  end


		  def index_productionForFinished
		    @user = User.new
		    @user = User.find(session[:user_id]).name
		    #@production_report = ProductionReport.all
		    if Date.today.month>=4
			@production_report = ProductionReport.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31")).order('issue_slip_no ASC')
				else
			@production_report = ProductionReport.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31")).order('issue_slip_no ASC')
				end
		    @pro = []
		    @production_report.each do |i| 
		    @k = i.issue_id 
		    if ProductionReport.exists?(:issue_id=> @k) and  Labour.exists?(:issue_id=> @k)
		    unless Finished.exists?(:production_report_id=> i.id)
			@pro << i
		    end
		end
	    end
	       @production_report = @pro.paginate(page: params[:page], per_page: 10)
	   end

		  def index_finished
		    @user = User.new
		    @user = User.find(session[:user_id]).name
		    #@finished = Finished.all
		    if Date.today.month>=4
			@finished = Finished.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
				else
			@finished = Finished.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
				end
		    @finished1 = @finished.paginate(page: params[:page], per_page: 10).order("issue_slip_no ASC")
		  end


		  def finished
		    @user = User.new
		    @user = User.find(session[:user_id]).name
		    @production_report = ProductionReport.find (params[:id])
		    @i_id = @production_report.issue_id
		    @issue = Issue.find_by ("id LIKE '%#{@i_id}%'")
		    @labour = Labour.find_by ("issue_id LIKE '%#{@i_id}%'")
		    @finished = Finished.new
		  end

		  def get_finished
		    @finished = Finished.new(finished_params)
		    if @finished.save
		      flash[:notice] = "Saved!!!"
		      redirect_to :action => "index_finished"
		    else
		      flash.now[:notice] = "Not Saved"
		      render "finished"
		    end
		  end

		  def show_finished
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @finished = Finished.find params[:id]
		    @p_id = @finished.production_report_id
		    @production_report = ProductionReport.where("id LIKE '%#{@p_id}%'")
		    @i_id = @production_report[0].issue_id
		    @issue = Issue.where("id LIKE '%#{@i_id}%'")
		    @labour = Labour.where("issue_id LIKE '%#{@i_id}%'")
		  end

		  def edit_finished
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @finished = Finished.find params[:id]
		    @p_id = @finished.production_report_id
		    @production_report = ProductionReport.where("id LIKE '%#{@p_id}%'")
		    @i_id = @production_report[0].issue_id
		    @issue = Issue.where("id LIKE '%#{@i_id}%'")
		    @labour = Labour.where("issue_id LIKE '%#{@i_id}%'")
		  end

		  def update_finished
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @finished = Finished.find (params[:id])
		    if @finished.update_attributes(finished_params)
		       flash[:notice] = "Finished Updated Successfully!!!"
		       redirect_to :action=> "index_finished"
		    else
		       render "edit_finished"
		    end
		  end

		  def delete_finished
		    @finished = Finished.find params[:id]
		    @finished.destroy
		    flash[:notice] = "Finished Deleted Successfully!!!"
		    redirect_to :action=>"index_finished"
		  end



		  def rate_per_kgs_report
		   @user=User.new
		   @user = User.find(session[:user_id]).name
		    @rts=params[:production_report][:intial_date]
		    @rte=params[:production_report][:final_date]
		    @production_report = ProductionReport.where(:date => @rts..@rte)
		    @production = @production_report.select(:finished_goods_name).uniq
		    @arr=[]
		    g = 0
		    @production.each do|i|
		      @p = @production_report.pluck(:issue_id)
		      @ll = @production_report.where(:finished_goods_name=>i.finished_goods_name).select(:no_of_kgs_used_for_production).sum :no_of_kgs_used_for_production
		      @k = Issue.where(:id=>@p).pluck(:consolidated_cost)
		      @rate = @k[g].to_f / @ll.to_f
		      @r = @rate.round(2)
		      @arr<<[i.finished_goods_name]+[@ll]+ [@k[g]] + [@r]
		      g = g+1
		      end
		    @total=@arr.inject(0){|sum,x| sum + x[1].to_i }
		    @total1=@arr.inject(0){|sum,y| sum + y[2].to_f }
		    @total2=@arr.inject(0){|sum,z| sum + z[3].to_f }
		  end
		  
		   def rate_per_kgs_xls_report  
		     @production_report = ProductionReport.where(:date => @rts..@rte)
		   end

		  def finished_goods_report
		   @user=User.new
		   @user = User.find(session[:user_id]).name
		    @fs=params[:production_report][:intial_date]
		    @fe=params[:production_report][:final_date]
		    @production_report = ProductionReport.where(:date => @fs..@fe)
		    @production = @production_report.select(:finished_goods_name).uniq
		    @arr=[]
		    @production.each do|i|
		      @ll=@production_report.where(:finished_goods_name=>i.finished_goods_name).select(:no_of_kgs_used_for_production).sum :no_of_kgs_used_for_production
		      @arr<<[i.finished_goods_name]+[@ll]
		      end
		    @total=@arr.inject(0){|sum,x| sum + x[1].to_i }
		  end

		  def finished_goods_xls_report
		   @production_report = ProductionReport.where(:date => @fs..@fe)
		  end

		  def yield_cost
	      @user = User.new
		  @user = User.find(session[:user_id]).name
		end

		def yield_cost_report
			@user=User.new
			@user = User.find(session[:user_id]).name
			@s_date = params[:labour][:intial_date]
			@e_date = params[:labour][:final_date]
			@i_id = Issue.where(:issue_date => @s_date..@e_date).pluck(:id)
			@arr = []
		@i_id.each do |i|
		    if ProductionReport.exists?(:issue_id=>i) && Labour.exists?(:issue_id=>i)
			pr = ProductionReport.where(:issue_id => i).pluck(:rejected_nos, :finished_goods_name, :weight_per_item, :total_weight_consumed)
			pr << Labour.where(:issue_id => i).pluck(:shift, :machine_no, :mould, :total_no_of_items_produced)
			pr << Issue.where(:id => i).pluck(:chemicals,:rm_issues,:rg_qty_return, :generated, :consolidated_qty, :consolidated_cost)
			pr = pr.flatten
			p = (pr[3].to_f != 0) ? ((pr[11].to_f/pr[3].to_f)*100).round(3)  : "--"
			pr << p
			q = (pr[12].to_f != 0) ? (pr[13].to_f/pr[12].to_f).round(3) : "--"
			pr << q
		    r = (pr[7].to_f != 0) ? (pr[13].to_f/pr[7].to_f).round(3) : "--"
		    pr << r
			@pr = Array.new << pr[4] << pr[5] << pr[1] << pr[6] << pr[9] << pr[8] << pr[2] << pr[7] << pr[0] << pr[10] << pr[11] << pr[14] << pr[15] << pr[16]
		    @arr << @pr
		    end
		end
	    end
		  
		   def yield_cost_report_xls
	      @issue = Issue.where(:issue_date => @s_date..@e_date)
	      end

		  

		  def report_idle_time
		@user=User.new
		   @user = User.find(session[:user_id]).name
	      end

		  def idle_time_report
		   @user=User.new
	   @user = User.find(session[:user_id]).name
		    @bb=params[:labour][:intial_date]
		    @aa=params[:labour][:final_date]
		   @labour=Labour.where(:date => @bb..@aa)
		  @ss=[]
		  @labour.each do |i|
                unless i.no_of_mins_idle == "0.0000" or i.no_of_mins_idle == "0"
		  pr = i.production_report_id
		   if ProductionReport.exists?(:id=>pr)
		  @as= ProductionReport.where(:id => pr).pluck(:finished_goods_name)          
		 @pr1 = Array.new << i.shift,i.machine_no,i.mould,i.expected_production,i.total_no_of_items_produced,i.no_of_mins_idle,i.reasons_for_idle,i.supervisor_name,i.issue_date
		  @g =  @as + @pr1
		  @g1 = @g.flatten 
		  #@pr = Array.new 
		   @ss << [@g1[9]] + [@g1[1]]+[@g1[2]]+[ @g1[0]]+[ @g1[3]]+[@g1[4].to_f.round(3)]+[@g1[5]]+[@g1[6].to_i]+[@g1[7]]+[@g1[8]]
		  #@ss = Array.new << @pr 
		  end
		  end
		  end
                  end

		   def idle_time_report_xls
		      @labour=Labour.where(:date => @bb..@aa)
		   end   

		   def report_rejection_analysis
		       @user=User.new
		       @user = User.find(session[:user_id]).name
		       end

		   def rejection_analysis  #RejectionAnalysis
		   @user=User.new
		   @user = User.find(session[:user_id]).name
		#  @production_report = ProductionReport.new
		   @i_date = params[:production_report][:intial_date]
		   @f_date = params[:production_report][:final_date]
		   @i_id = Issue.where(:issue_date => @i_date..@f_date).pluck(:id)
			   @arr = []
		   @i_id.each do |i|
		     if ProductionReport.exists?(:issue_id=>i) && Labour.exists?(:issue_id=>i) 	 
			pr = ProductionReport.where(:issue_id => i).pluck(:shift, :finished_goods_name, :rejected_nos, :reason_rejection, :total_weight_consumed,:rejected_nos_wt_for_re_grounding)
			pr << Labour.where(:issue_id => i).pluck(:no_of_cavity, :supervisor_name)
			pr << Issue.where(:id => i).pluck(:rm_issues,:generated)
			pr = pr.flatten
			re = (pr[4].to_f != 0) ? (((pr[5].to_f + pr[9].to_f)/pr[4].to_f) * 100).round(3) : "--"
		    pr << re
        pr << ProductionReport.where(:issue_id => i).pluck(:action_taken,:issue_date)
        pr = pr.flatten        
			@pr = Array.new << pr[0] << pr[1] << pr[8] << pr[6] << pr[2] << pr[10]<< pr[3] << pr[7] << pr[11] << pr[12]
			@arr << @pr
		     end
		end
	    end

	    def rejection_analysis_xls_report
	       @production_report = ProductionReport.where(:date => $ras..$rae)
	    end
	 

		    def party_production
		      @user=User.new
		      @user = User.find(session[:user_id]).name
		      @a=params[:production_report][:intial_date]
		      @m=params[:production_report][:final_date]
		      @production_report=ProductionReport.where(:date => @a..@m)
		      @lab=@production_report.select(:party).uniq
		      @arr=[]
		      @aass=[]
		      g = 0
		      h = 0
		      @lab.each do|i|
			@p = @production_report.pluck(:issue_id)
			@m = Issue.where(:id=>@p).pluck(:order_summary_id)
			@mm = Issue.where(:id=>@p).pluck(:consolidated_qty)
			@arrr=@production_report.where(:party=>i.party).select(:no_of_kgs_used_for_production).sum :no_of_kgs_used_for_production
			@arr = @arrr.to_f
			@am = @arr.round(3)
			@nn = OrderSummary.where(:id=>@m).pluck(:nos)
		#        @n = @nn
		#        @s = @mm
			@pp = @nn[g].to_i - @mm[h].to_i
			@aass<<[i.party]+[@am]+[@pp]
			g =g + 1
			end
		      @ass = @aass.sort_by{|i| i[1].to_i}.reverse
		      @total=@ass.inject(0){|sum,x| sum + x[1].to_f}
		      @total1 = @ass.inject(0){|sum,y| sum + y[2].to_f}
		      @total2 = @ass.inject(0){|sum,z| sum + z[3].to_f}
		    end

		    def party_production_xls_report
		     @production_report=ProductionReport.where(:date => @a..@m)
		    end

		    def supervisor_name_report
		     @user=User.new
		   @user = User.find(session[:user_id]).name
		    @aa=params[:labour][:intial_date]
		    @mm=params[:labour][:final_date]
		    @labour=Labour.where(:date => @aa..@mm)

		#    @sup=@labour.select(:supervisor_name).uniq
		    @lab=@labour.select(:supervisor_name,:reasons_for_idle).uniq
		    @ass=[]
		    @lab.each do|i|

		  @ll=@labour.where(:reasons_for_idle=>i.reasons_for_idle).select(:no_of_mins_idle).sum :no_of_mins_idle
		      @ass<<[i.supervisor_name] +[i.reasons_for_idle]+[@ll]
		    end
		      @total=@ass.inject(0){|sum,x| sum + x[2].to_i }
		   end

		   def supervisor_xls_report
		    @labour=Labour.where(:date => @aa..@mm)
		   end

		    def finished_production
		      @user=User.new
		      @user = User.find(session[:user_id]).name
		      @nn=params[:production_report][:intial_date]
		      @mm=params[:production_report][:final_date]
		      @production_report=ProductionReport.where(:date => @nn..@mm)
		      @lab=@production_report.select(:finished_goods_name).uniq
		      @aass=[]
		      g=0
		      h=0
		      @lab.each do|i|
			@p = @production_report.pluck(:issue_id)
			@m = Issue.where(:id=>@p).pluck(:order_summary_id)
			@mm = Issue.where(:id=>@p).pluck(:consolidated_qty)
			@nn = OrderSummary.where(:id=>@m).pluck(:total_kgs)
			@pp = @nn[g].to_i - @mm[h].to_i
			@aass<<[i.finished_goods_name]+[@pp]
			g = g + 1
			h = h + 1
			end
		      @total=@aass.inject(0){|sum,x| sum + x[1].to_i}
		      end
		   
		    def finished_xls_report
		     @production_report=ProductionReport.where(:date => @nn..@mm)
		    end
		 
		    def party_order_qty
		      @user=User.new
		   @user = User.find(session[:user_id]).name
		    $p=params[:order_summary][:intial_date]
		    $q=params[:order_summary][:final_date]
		    $r=params[:order_summary][:party]
		    @order_summary=OrderSummary.where(:order_date => $p..$q)
		    @order_summary=OrderSummary.where(:party => $r)
		    @qty=@order_summary.select(:party).uniq
		    @arr=[]
		    @qty.each do|i|
		    @ll=@order_summary.where(:party=>i.party).select(:nos).sum :nos
		     @arr<<[i.party]+[@ll]
		    end
		      @total=@arr.inject(0){|sum,x| sum + x[1].to_i }

			@order_summary=OrderSummary.order_report_to_csv
			 respond_to do |format|
			 format.html
			 format.csv { send_data @order_summary.order_report_to_csv }
			 format.xls #{ send_data @order_summary.order_report_to_csv(col_sep: "\t") }
			end
		    end

		   def party_order_qty_report
		     @order_summary=OrderSummary.where(:order_date => $p..$q)
		     @order_summary=OrderSummary.where(:party => $r)
		   end

		   def finished_order_qty
		     @user=User.new
		   @user = User.find(session[:user_id]).name
		      $p=params[:order_summary][:intial_date]
		    $q=params[:order_summary][:final_date]
		    $r=params[:order_summary][:goods_finished]
		    @order_summary=OrderSummary.where(:order_date => $p..$q)
		    @order_summary=OrderSummary.where(:goods_finished => $r)
		    @qty=@order_summary.select(:goods_finished).uniq
		    @arr=[]
		    @qty.each do|i|
		    @ll=@order_summary.where(:goods_finished=>i.goods_finished).select(:nos).sum :nos
		     @arr<<[i.goods_finished]+[@ll]
		    end
		      @total1=@arr.inject(0){|sum,x| sum + x[1].to_f}
		     @order_summary=OrderSummary.order_report_to_csv
			 respond_to do |format|
			 format.html
			 format.csv { send_data @order_summary.order_report_to_csv }
			 format.xls #{ send_data @order_summary.order_report_to_csv(col_sep: "\t") }
			end    
		    end

		    def finished_order_qty_report
		     @order_summary=OrderSummary.where(:order_date => $p..$q)
		     @order_summary=OrderSummary.where(:goods_finished => $r)
		   end

		  def index_issuesForReturn
		     @user=User.new
		   @user = User.find(session[:user_id]).name
		   if Date.today.month>=4
			@issue = Issue.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31")).order("issue_slip_no ASC")
				else
			@issue = Issue.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31")).order("issue_slip_no ASC")
				end
		      @issue = @issue.paginate(page: params[:page], per_page: 10)
		  end


		  def index_return
		   @user = User.new
		   @user = User.find(session[:user_id]).name
		   if Date.today.month>=4
			@issue = Issue.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
				else
			@issue = Issue.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
				end
		   #@issue = Issue.all
				if Date.today.month>=4
			@return = Ireturn.where(:created_at=>("#{Time.now.year}-04-01")..("#{Time.now.year+1}-03-31"))
				else
			@return = Ireturn.where(:created_at=>("#{Time.now.year-1}-04-01")..("#{Time.now.year}-03-31"))
				end
		   @return = Ireturn.all.paginate(page: params[:page], per_page: 10).order("issue_slip_no ASC")
		  end

		  def return_report
		    @user = User.new
		   @user = User.find(session[:user_id]).name
		   $rn=params[:ireturn][:initial_date]
		   $nr=params[:ireturn][:final_date]
		    @issue = Issue.where(:issue_date => $rn..$nr)
		   @return = Ireturn.where(:order_date => $rn..$nr)
		   @return=Ireturn.ireturn_report_to_csv
			 respond_to do |format|
			 format.html
			 format.csv { send_data  @return.ireturn_report_to_csv }
			 format.xls #{ send_data  @return.order_report_to_csv(col_sep: "\t") }
			end
		  end

		  def return_xls_report
		#   @return = Ireturn.where(:order_date => @rn..@nr)
		   @issue = Issue.where(:issue_date => $rn..$nr).select(:id)
		  end 

		  def add_return
		    @user = User.new
		    @user = User.find(session[:user_id]).name
		    @issue = Issue.find (params[:id])
		    @return = Ireturn.new
		  end

		  def get_return
		    @return = Ireturn.new(ireturn_params)
		    if @return.save
		      flash[:notice] = "Saved!!!"
		      redirect_to :action => "index_return"
		    else
		      flash.now[:notice] = "Not Saved"
		      render "add_report"
		    end
		  end

		  def show_return
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @issue = Issue.find(params[:id])
		    @i_id = @issue.id
		    @return = Ireturn.where("issue_id LIKE '%#{@i_id}%'")
		  end    

		  def edit_return
		    @user = User.new
		    @user = User.find(session[:user_id]).name
		    @issue = Issue.find(params[:id])
		    @i_id = @issue.id
		    @return = Ireturn.where("issue_id LIKE '%#{@i_id}%'")

		  end

		  def update_return
		    @user = User.new
		    @user = User.find(session[:user_id]).name
		    @return = Ireturn.find params[:id]
		    if @return.update_attributes(ireturn_params)
		       flash[:notice] = "Return Updated Successfully!!!"
		       redirect_to :action=> "index_return"
		    else
		       render "edit_return"
		    end
		  end


		  def delete_return
		    @issue = Issue.find(params[:id])
		    @i_id = @issue.id
		    @return = Ireturn.where("issue_id LIKE '%#{@i_id}%'")
		    @return[0].destroy
		    flash[:notice] = "Return Deleted Successfully!!!"
		    redirect_to :action=>"index_return"
		  end
		 

		  def trash_orderSummary
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @order_summary = OrderSummary.only_deleted
		    @order_summary = OrderSummary.only_deleted.all.paginate(page: params[:page], per_page: 10).order("deleted_at DESC")
		  end

		  def trash_purchase
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @purchase = Purchase.only_deleted
		    @purchase = Purchase.only_deleted.all.paginate(page: params[:page], per_page: 10).order("deleted_at DESC")
		  end

		  def trash_issue
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @issue = Issue.only_deleted
		    @issue = Issue.only_deleted.all.paginate(page: params[:page], per_page: 10).order("deleted_at DESC")
		  end


		  def trash_labour
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @labour = Labour.only_deleted
		    @labour = Labour.only_deleted.all.paginate(page: params[:page], per_page: 10).order("deleted_at DESC")
		  end

		  def trash_production
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @production_report = ProductionReport.only_deleted
		    @production_report = ProductionReport.only_deleted.all.paginate(page: params[:page], per_page: 10).order("deleted_at DESC")
		  end

		  def trash_finished
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @finished = Finished.only_deleted
		    @finished = Finished.only_deleted.all.paginate(page: params[:page], per_page: 10).order("deleted_at DESC")
		  end

		  def trash_return
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @return = Ireturn.only_deleted
		    @return = Ireturn.only_deleted.all.paginate(page: params[:page], per_page: 10).order("deleted_at DESC")
		  end

		  def trash_machine_maintenance
		    @user=User.new
		    @user = User.find(session[:user_id]).name
		    @machine_maintenance = MachineMaintenance.only_deleted
		    @machine_maintenance = MachineMaintenance.only_deleted.all.paginate(page: params[:page], per_page: 10).order("deleted_at DESC")
		  end

		  def trash_showPurchase
        @purchase = Purchase.only_deleted.find params[:id]
      end

      def trash_showOrderSummary
		    @order_summary = OrderSummary.only_deleted.find params[:id]
		  end

		  def trash_showIssue
        @issue = Issue.only_deleted.find params[:id]
		  end

		  def trash_showProduction
		    @production_report = ProductionReport.only_deleted.find params[:id]
        @i_id = @production_report.issue_id
        if Issue.only_deleted.exists?(:id => @i_id) then
          @issue = Issue.only_deleted.find_by("id LIKE '%#{@i_id}%'")
        else Issue.exists?(:id => @i_id)
          @issue = Issue.find_by("id LIKE '%#{@i_id}%'")                 
        end
          @cost = Cost.last
		  end

      def trash_showLabour
        @labour = Labour.only_deleted.find params[:id]
        @i_id = @labour.issue_id
        if Issue.only_deleted.exists?(:id => @i_id) then
        @issue = Issue.only_deleted.find_by ("id LIKE '%#{@i_id}%'")
      else Issue.exists?(:id => @i_id) 
        @issue = Issue.find_by("id LIKE '%#{@i_id}%'")
      end
      if ProductionReport.only_deleted.exists?(:issue_id => @i_id) then
        @production_report = ProductionReport.only_deleted.find_by("issue_id LIKE '%#{@i_id}%'")
      else ProductionReport.exists?(:issue_id => @i_id)
        @production_report = ProductionReport.find_by("issue_id LIKE '%#{@i_id}%'")
      end
    end

		  def trash_showFinished
		    @finished = Finished.only_deleted.find params[:id]
		    @p_id = @finished.production_report_id
        if ProductionReport.only_deleted.exists?(:id => @p_id) then
		    @production_report = ProductionReport.only_deleted.where("id LIKE '%#{@p_id}%'")
      else ProductionReport.exists?(:id => @p_id)
        @production_report = ProductionReport.where("id LIKE '%#{@p_id}%'")
      end
		    @i_id = @production_report[0].issue_id
        if Issue.only_deleted.exists?(:id => @i_id) then
		    @issue = Issue.only_deleted.where("id LIKE '%#{@i_id}%'")
      else Issue.exists?(:id => @i_id)
        @issue = Issue.where("id LIKE '%#{@i_id}%'")
      end
      if Labour.only_deleted.exists?(:issue_id => @i_id) then
		    @labour = Labour.only_deleted.where("issue_id LIKE '%#{@i_id}%'") 
      else Labour.exists?(:issue_id => @i_id)
        @labour = Labour.where("issue_id LIKE '%#{@i_id}%'")
      end
    end

		  def trash_showReturn
		  	@return = Ireturn.only_deleted.find params[:id]
			  @i_id = @return.issue_id
        if Issue.only_deleted.exists?(:id => @i_id) then      
			  @issue = Issue.only_deleted.find_by("id LIKE '%#{@i_id}%'")
      else Issue.exists?(:id => @i_id)
        @issue = Issue.find_by("id LIKE '%#{@i_id}%'")
      end
    end
		  
      def trash_showMachineMaintenance
			  @machine_maintenance = MachineMaintenance.only_deleted.find params[:id]
		  end


		  def delete_trashOrderSummary
			  @pp = params[:id]
		    @v = Issue.only_deleted.where(:order_summary_id => @pp).pluck(:id)
		    @c = []
		    @c << @v
		    @kk1=@c.flatten
		    @v.each do  |i|
		    if Labour.only_deleted.exists?(:issue_id => i) then
		    Labour.only_deleted.find_by(:issue_id => i).really_destroy!
		    end
		    if ProductionReport.only_deleted.exists?(:issue_id => i) then
		    ProductionReport.only_deleted.find_by(:issue_id => i).really_destroy!
		    end
		  end
		    @v.map { |i| Issue.only_deleted.find(i).really_destroy! }
		    OrderSummary.only_deleted.find(@pp).really_destroy!
		    flash[:notice] = "Order Deleted Permanently!!!"
		    redirect_to :action=>"trash_orderSummary"
		  end

		  def delete_trashPurchase
		    @purchase = Purchase.only_deleted.find params[:id]
		    @purchase.really_destroy!
		    flash[:notice] = "Purchase Deleted Permanently!!!"
		    redirect_to :action=>"trash_purchase"
		  end

		  def delete_trashIssue
			pp = params[:id]
		  if Labour.only_deleted.exists?(:issue_id => pp) then
		    Labour.only_deleted.find_by(:issue_id => pp).really_destroy!
		  end
		  if ProductionReport.only_deleted.exists?(:issue_id => pp) then
		    ProductionReport.only_deleted.find_by(:issue_id => pp).really_destroy!
		  end
		  if Ireturn.only_deleted.exists?(:issue_id => pp) then
		    Ireturn.only_deleted.find_by(:issue_id => pp).really_destroy!
		  end
		  Issue.only_deleted.find(pp).really_destroy!
		 #   @issue = Issue.only_deleted.find params[:id]
		 #   @issue.really_destroy!
		    flash[:notice] = "Issue Deleted Permanently!!!"
		    redirect_to :action=>"trash_issue"
		  end

		  def delete_trashLabour
		    @labour = Labour.only_deleted.find params[:id]
		    @labour.really_destroy!
		    flash[:notice] = "Labour Deleted Permanently!!!"
		    redirect_to :action=>"trash_labour"
		  end


		  def delete_trashProduction
			pr = params[:id]
		       if Labour.only_deleted.exists?(:production_report_id => pr) then
		     Labour.only_deleted.find_by(:production_report_id => pr).really_destroy!
		   end
		   if Finished.only_deleted.exists?(:production_report_id => pr) then
		     Finished.only_deleted.find_by(:production_report_id => pr).really_destroy!
		   end
		   ProductionReport.only_deleted.find(pr).really_destroy!
		    # @production_report = ProductionReport.only_deleted.find params[:id]
		    # @production_report.really_destroy!
		    flash[:notice] = "Production Report Deleted Permanently!!!"
		    redirect_to :action=>"trash_production"
		  end

		  def delete_trashFinished
		    @finished = Finished.only_deleted.find params[:id]
		    @finished.really_destroy!
		    flash[:notice] = "Finished Deleted Permanently!!!"
		    redirect_to :action=>"trash_finished"
		  end

		  def delete_trashReturn
		    @return = Ireturn.only_deleted.find params[:id]
		    @return.really_destroy!
		    flash[:notice] = "Return Deleted Permanently!!!"
		    redirect_to :action=>"trash_return"
		  end

		  def delete_trashMachine
		    @machine_maintenance = MachineMaintenance.only_deleted.find params[:id]
		    @machine_maintenance.really_destroy!
		    flash[:notice] = "Machine Maintenance Deleted Permanently!!!"
		    redirect_to :action=>"trash_machine_maintenance"
		  end


		  def restore_trashOrderSummary
		    @order_summary = OrderSummary.only_deleted.find params[:id]
		    @order_summary.restore
		    flash[:notice] = "Order Restored Successfully!!!"
		    redirect_to :action=>"trash_orderSummary"
		  end

		  def restore_trashPurchase
		    @purchase = Purchase.only_deleted.find params[:id]
		    @purchase.restore
		    flash[:notice] = "Purchase Restored Successfully!!!"
		    redirect_to :action=>"trash_purchase"
		  end

		  def restore_trashIssue
		    @issue = Issue.only_deleted.find params[:id]
		    @issue.restore
		    flash[:notice] = "Issue Restored Successfully!!!"
		    redirect_to :action=>"trash_issue"
		  end

		  def restore_trashLabour
		    @labour = Labour.only_deleted.find params[:id]
		    @labour.restore
		    flash[:notice] = "Labour Restored Successfully!!!"
		    redirect_to :action=>"trash_labour"
		  end


		  def restore_trashProduction
		    @production_report = ProductionReport.only_deleted.find params[:id]
		    @production_report.restore
		    flash[:notice] = "Production Report Restored Successfully!!!"
		    redirect_to :action=>"trash_production"
		  end

		  def restore_trashFinished
		    @finished = Finished.only_deleted.find params[:id]
		    @finished.restore
		    flash[:notice] = "Finished Restored Successfully!!!"
		    redirect_to :action=>"trash_finished"
		  end

		  def restore_trashReturn
		    @return = Ireturn.only_deleted.find params[:id]
		    @return.restore
		    flash[:notice] = "Return Restored Successfully!!!"
		    redirect_to :action=>"trash_return"
		  end

	       def restore_trashMachine
		    @machine_maintenance = MachineMaintenance.only_deleted.find params[:id]
		    @machine_maintenance.restore
		    flash[:notice] = "Machine Maintenance Restored Successfully!!!"
		    redirect_to :action=>"trash_machine_maintenance"
		  end



		  private
		  def user_params
		   params.require(:user).permit!
		  end

		  def purchase_params
		   params.require(:purchase).permit!
		  end
		  
		  def issues_params
		   params.require(:issue).permit!
		  end
		  
		  def labour_params
		   params.require(:labour).permit!
		  end
		  
		  def order_summary_params
		   params.require(:order_summary).permit!
		  end

		   def production_report_params
		      params.require(:production_report).permit!
		  end
		   def chemical_type_params
		     params.require(:chemical_type).permit!
		   end

		   def chemical_params
		     params.require(:chemical).permit!  
		   end

		   def party_order_params
		    params.require(:party_order).permit!
		   end 

		   def party_purchase_params
		    params.require(:party_purchase).permit!
		   end

		   def ra_material_params
		    params.require(:raw_material).permit!
	   end

	   def reasonidle_params
	      params.require(:reason_for_idle_time).permit!
	   end

	   def nature_params
	    params.require(:nature_of_work).permit!
	   end

	   def goods_params
	      params.require(:finished_goods_name).permit!
	   end

	   def mould_params
	     params.require(:mould_no).permit!
	   end

     def cost_params
       params.require(:cost).permit!
     end

	   def machine_use_params
	    params.require(:machine_used).permit!
	   end

	   def finished_params
	    params.require(:finished).permit!
     end
   
     def supervisor_params
      params.require(:name_of_supervisor).permit!
     end

     def ireturn_params
      params.require(:ireturn).permit!
     end

    def purchase_type_params
      params.require(:type_of_purchase).permit!
  end

  def reground_params
    params.require(:reground).permit!
  end

  def insert_material_params
    params.require(:insert_material).permit!
  end

  def machine_maintenance_params
     params.require(:machine_maintenance).permit!
 end

 def rejection_reason_params
 	params.require(:rejection_reason).permit!
 end

  
end
