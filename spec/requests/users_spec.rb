# TODO: WRITE TESTS

# require 'rails_helper'

# RSpec.describe "Users Api", type: :request do
#     let!(:users) { create_list(:user, 10) }
#     let(:user_id) { users.first.id }

#     describe 'GET /users' do
#         before { get '/users' }

#         it 'returns users' do
#             expect(json).not_to be_empty
#             expect(json.size).to eq(10)
#         end

#         it 'returns status code 200' do
#             expect(response.status).to eql(200)
#         end
#     end

#     describe 'GET /users/:id' do
#         before { get "/users/#{user_id}" }

#         context "when the user exists" do
#             it "returns the user" do
#                 expect(json).not_to be_empty
#                 expect(json['id']).to eq(user_id)
#             end

#             it "returns status code 200" do
#                 expect(response.status).to eql(200)
#             end
#         end

#         context " when user does not exist" do
#             let(:user_id) { 100 }

#             it "returns status code 404" do
#                 expect(response.status).to eql(404)
#             end

#             it "returns a not found message" do
#                 expect(response.body).to match(/Couldn't find user/)
#             end
#         end
#     end

#     describe "POST /users" do
#         let(:valid_attributes) {
#              { email: 'guest@exmple.com', roles: ['guest'] }
#             }

#         context "when the request is valid" do
#             before { post '/users', params: valid_attributes }

#             it "creates a user" do
#                 expect(json['email']).to eq('guest@exmple.com')
#             end

#             it "creates a status code 201" do
#                 expect(response.status).to eql(201)
#             end
#         end

#         # context "when request is invalid" do
#         #     before { post '/users', params: { email: 'guest@exmple.com' } }

#         #     it "returns status code 400" do
#         #         expect(response.status).to eql(400)
#         #     end

#         #     it "returns a validation failure" do
#         #         expect(response.body).to match(/Invalid JSON/)
#         #     end
#         # end
#     end

#     describe "PUT /users/:id" do
#         let(:valid_attributes) { { email: 'sample@exmple.com'} }

#         context "when the record exists" do
#             before { put "/users/#{user_id}", params: valid_attributes }

#             it "updates the record" do
#                 expect(response.body).to match(/sample@exmple.com/)
#             end

#             it "returns status code 200" do
#                 expect(response.status).to eql(200)
#             end
#         end
#     end

#     describe "DELETE /users/:id" do
#         before { delete "/users/#{user_id}" }

#         it "deletes the record" do
#             expect(response.body).to match(/success/)
#         end

#         it "returns status code 200" do
#             expect(response.status).to eql(200)
#         end
#     end
# end


