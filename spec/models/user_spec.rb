require 'rails_helper'

describe User do
  it "is valid with an email address, password and password confirmation" do
    user = User.new(
      email: 'user@example.com',
      phone: '0221234123',
      password: 'password',
      password_confirmation: 'password')
    expect(user).to be_valid
  end

  it "is invalid without an email address" do
    user = User.new(
      email: '',
      phone: '0221234123',
      password: 'password',
      password_confirmation: 'password')
    expect(user).not_to be_valid
  end

  it "is invalid with an invalid email address format" do
    user = User.new(
      email: 'greg',
      phone: '0221234123',
      password: 'password',
      password_confirmation: 'password')
    expect(user).not_to be_valid
  end

  it "is invalid without a phone number" do
    user = User.new(
      email: 'greg@example.com',
      phone: '',
      password: 'password',
      password_confirmation: 'password')
    expect(user).not_to be_valid
  end

  it "is invalid when phone is less than 7 digits" do
    user = User.new(
      email: 'greg@example.com',
      phone: '1234',
      password: 'password',
      password_confirmation: 'password')
    expect(user).not_to be_valid
  end
end
