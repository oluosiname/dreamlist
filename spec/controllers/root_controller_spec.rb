require 'rails_helper'

RSpec.describe RootController, type: :controller do

  context "visit root" do
    it "redirecst to apiary page" do
      expect(get :index).to redirect_to ("http://docs.dreamlist.apiary.io/")
    end
  end
end
