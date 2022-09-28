json.extract! invoice, :id, :amount, :due_date, :selling_price, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
