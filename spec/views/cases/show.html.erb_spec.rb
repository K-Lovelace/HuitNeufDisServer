require 'rails_helper'

RSpec.describe "cases/show", type: :view do
  before(:each) do
    @case = assign(:case, Case.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
