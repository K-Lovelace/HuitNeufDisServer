require 'rails_helper'

RSpec.describe "cases/new", type: :view do
  before(:each) do
    assign(:case, Case.new())
  end

  it "renders new case form" do
    render

    assert_select "form[action=?][method=?]", cases_path, "post" do
    end
  end
end
