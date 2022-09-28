class Invoice < ApplicationRecord
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
    invoice = find_by_id(row["id"]) || new  
    invoice.attributes = row.to_hash.slice(*row.to_hash.keys) 
    invoice.save
    amount = calculate_selling_price(row[0])
    invoice.selling_price = amount
    invoice.save
    end
  end

  def self.calculate_selling_price(id)
    invoice = Invoice.where(id: id)
    amount = invoice.pluck(:amount).first
    due_date = Date.parse(invoice.pluck(:due_date).first.to_s)
    todays_date = Date.parse(DateTime.now.to_s)

    if (todays_date.mjd - due_date.mjd) > 30
      amount = amount - (amount * 0.5)
    elsif (todays_date.mjd - due_date.mjd) <= 30
      amount = amount - (amount * 0.3)
    end
    amount
  end
end
