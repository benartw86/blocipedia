require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { Wiki.create!(title: "Title", body: "Body", boolean: true) }
  
  describe "attributes" do
    it "has title, body and boolean attributes" do
      expect(wiki).to have_attributes(title: "Title", body: "Body", boolean: true)
    end
  end
end
