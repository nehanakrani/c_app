# spec/requests/authentication_spec.rb

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'GET /users/sign_in' do
    it 'renders the sign-in page' do
      get new_user_session_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /users/sign_in' do
    it 'signs in the user' do
      user = User.create(email: 'user@example.com', password: 'password')
      post user_session_path, params: { user: { email: user.email, password: 'password' } }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE /users/sign_out' do
    it 'signs out the user' do
      user = User.create(email: 'user@example.com', password: 'password')
      sign_in user
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET /users/sign_up' do
    it 'renders the sign-up page' do
      get new_user_registration_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /users' do
    it 'creates a new user' do
      expect do
        post user_registration_path,
             params: { user: { email: 'newuser@example.com', password: 'password', password_confirmation: 'password' } }
      end.to change(User, :count).by(1)
      expect(response).to redirect_to(root_path)
    end
  end
end
