require_relative 'spec_helper'

describe User do
  let(:guest) { User.new(name: 'guest', password: 's3cr3t', admin: false) }
  let(:admin) { User.new(name: 'admin', password: 's3cr3t', admin: true ) }

  it 'can set the password disgest' do
    user = User.new
    password = 's3cr3t'

    expect(BCrypt::Password).to receive(:create).and_return(password)

    user.password = password
    expect(user.password_digest).to eq(password)
  end

  context '(authentication)' do
    it 'returns the user when authenticated' do
      expect(User).to receive(:first).with(name: 'guest').and_return(guest)
      expect(BCrypt::Password).to receive(:new).and_return('s3cr3t')
      expect(User.authenticate('guest', 's3cr3t')).to eq(guest)
    end

    it 'returns nil if there\'s no user' do
      expect(User).to receive(:first).with(name: 'interloper').and_return(nil)
      expect(User.authenticate('interloper', 's3cr3t')).to eq(nil)
    end

    it 'returns nil if the password is wrong' do
      expect(User).to receive(:first).with(name: 'guest').and_return(guest)
      expect(BCrypt::Password).to receive(:new).and_return('s3cr3t')
      expect(User.authenticate('guest', 'secret')).to eq(nil)
    end
  end
end