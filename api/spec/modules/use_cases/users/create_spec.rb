# frozen_string_literal: true

require "rails_helper"

RSpec.describe UseCases::Users::Create do
  let(:repository_adapter) { instance_double("UsersRepositoryAdapter") }

  context "create new user" do
    let(:create_user) do
      described_class.new(params: {name: "John", email: "j@j.com", password: "123456"},
        repository_adapter:)
    end

    it "calls user repository" do
      allow(repository_adapter).to receive(:create!)
        .and_return(Domain::User.new(id: IdProvider.new.next_id, name: "John", email: "j@j.com", password: "123456"))

      create_user.call

      expect(repository_adapter).to have_received(:create!).with(include({
        name: "John", email: "j@j.com", password: "123456"
      }))
    end
  end

  context "create user raise error" do
    let(:create_user) do
      described_class.new(params: {name: ""}, repository_adapter:)
    end

    it { expect { create_user.call }.to raise_error(UseCases::Users::CreateError) }
  end
end
