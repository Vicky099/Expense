class TransactionRecordsController < ApplicationController
  before_action :authenticate_user!
  def total_balance
    @transaction_records = current_user.transaction_records.order('id DESC').paginate(:page => params[:page], :per_page => 15)
  end

  def report

  end

  def download_pdf
    from = params[:record][:date_from] == '' ? Time.now.strftime('%Y-%m-%d') : params[:record][:date_from]
    to = params[:record][:date_to] == '' ? Time.now.strftime('%Y-%m-%d') : params[:record][:date_to]
    @record = current_user.transaction_records
    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new
        table_data = Array.new
        table_data << ["Process Name", "Process category & Description", "Amount", "Date"]
        if @record.present?
          @record.each do |p|
            if p.process.date >= Date.parse(from) && p.process.date <= Date.parse(to)
              if p.process_type == 'Income'
                category = p.process.income_category.income_source.to_s+' - '+p.process.description.to_s
              elsif p.process_type == 'Expense'
                category = p.process.expense_category.expense_source.to_s+' - '+p.process.description.to_s
              end
              table_data << [p.process_type, category, p.process.amount, p.process.date]
            end
          end
        end
        filename = "00#{current_user.id}#{Time.now.strftime("%Y%m%d%H%M%S")}.pdf"
        pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
        send_data pdf.render, filename: filename, type: 'application/pdf', :disposition => 'inline'
      end
    end
  end

end
