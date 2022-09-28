require "test_helper"

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invoice = invoices(:one)
  end

  test "should get index" do
    get invoices_url
    assert_response :success
  end

  test "should get new" do
    get new_invoice_url
    assert_response :success
  end

  test "should create invoice" do
    assert_difference("Invoice.count") do
      post invoices_url, params: { invoice: { amount: @invoice.amount, due_date: @invoice.due_date, selling_price: @invoice.selling_price } }
    end

    assert_redirected_to invoice_url(Invoice.last)
  end

  test "should show invoice" do
    get invoice_url(@invoice)
    assert_response :success
  end

  test "should get edit" do
    get edit_invoice_url(@invoice)
    assert_response :success
  end

  test "should update invoice" do
    patch invoice_url(@invoice), params: { invoice: { amount: @invoice.amount, due_date: @invoice.due_date, selling_price: @invoice.selling_price } }
    assert_redirected_to invoice_url(@invoice)
  end

  test "should destroy invoice" do
    assert_difference("Invoice.count", -1) do
      delete invoice_url(@invoice)
    end

    assert_redirected_to invoices_url
  end

  test "should import csv" do 
    csv_rows = <<-eos
    1,465.1,1920-07-09
    2,728.27,1979-05-15
    3,559.86,1930-07-22
    4,226.12,1979-08-19
    5,730.24,1957-09-04
  eos
  
    file = Tempfile.new('new_invoice.csv')
    file.write(csv_rows)
    file.rewind
  
    #  assert_difference "Invoice.count", 5 do
      # post import_invoices_url('/Users/nilesh/Downloads/myFile0.csv')
    #  end
  
    # assert_redirected_to invoices_path
    # assert_equal "Successfully imported!", flash[:notice]
  end
end
