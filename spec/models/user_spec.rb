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

  it "is invalid when email is not unique" do
    user = User.create(
      email: 'greg@example.com',
      phone: '123456789',
      password: 'password',
      password_confirmation: 'password')
    user2 = User.new(
      email: 'greg@example.com',
      phone: '123456789',
      password: 'password',
      password_confirmation: 'password')
    expect(user2).not_to be_valid
    expect(user2.errors[:email]).to include("has already been taken")
  end

  it "is invalid when phone number is not unique" do
    user = User.create(
      email: 'greg@example.com',
      phone: '123456789',
      password: 'password',
      password_confirmation: 'password')
    user2 = User.new(
      email: 'greg2@example.com',
      phone: '123456789',
      password: 'password',
      password_confirmation: 'password')
    expect(user2).not_to be_valid
    expect(user2.errors[:phone]).to include("has already been taken")
  end
end
