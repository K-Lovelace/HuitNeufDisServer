require 'rails_helper'

RSpec.describe "cases/index", type: :view do
  before(:each) do
    assign(:cases, [
      Case.create!(),
      Case.create!()
    ])
  end

  it "renders a list of cases" do
    render
  end
end
