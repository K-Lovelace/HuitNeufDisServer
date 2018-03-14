require 'rails_helper'

RSpec.describe "cases/edit", type: :view do
  before(:each) do
    @case = assign(:case, Case.create!())
  end

  it "renders the edit case form" do
    render

    assert_select "form[action=?][method=?]", case_path(@case), "post" do
    end
  end
end
