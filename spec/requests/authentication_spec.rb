require "rails_helper"

RSpec.describe "Authentication navigation", type: :request do
  it "keeps events available when Clerk is not configured" do
    allow(Clerk.configuration).to receive(:publishable_key).and_return(nil)

    get root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Authentication unavailable")
    expect(response.body).not_to include('data-controller="clerk"')
  end

  it "renders the Clerk controls without exposing the secret key" do
    allow(Clerk.configuration).to receive(:publishable_key).and_return("pk_test_example")
    allow(Clerk.configuration).to receive(:secret_key).and_return("sk_test_private")

    get root_path

    page = Nokogiri::HTML(response.body)
    auth = page.at_css('[data-controller="clerk"]')
    expect(auth["data-clerk-publishable-key-value"]).to eq("pk_test_example")
    expect(auth.css("button").map(&:text)).to eq([ "Sign in", "Sign up", "Sign out" ])
    expect(response.body).not_to include("sk_test_private")
  end
end
