# frozen_string_literal: true

require "support/product_component"
require "shoulda/matchers/view_component/use_collection_parameter"

RSpec.describe Shoulda::Matchers::ViewComponent::UseCollectionParameter do
  let(:green_matcher) { described_class.new(:product) }
  let(:red_matcher) { described_class.new(:user) }

  describe "#matches?" do
    context "with passing values" do
      it { expect(green_matcher.matches?(ProductComponent)).to eq(true) }
    end

    context "with failing values" do
      it { expect(red_matcher.matches?(ProductComponent)).to eq(false) }
    end

    context "with all modifiers and passing values" do
      it do
        expect(green_matcher.with_counter.with_iteration.matches?(ProductComponent)).to \
          eq(true)
      end
    end
  end

  describe "#description" do
    context "with no modifiers" do
      subject { green_matcher.description }

      it do
        is_expected.to \
          eq("use collection parameter :product with matching " \
             "#initialize(product:[, ...]) keyword argument")
      end
    end

    context "with all modifiers" do
      subject { green_matcher.with_counter.with_iteration.description }

      it do
        is_expected.to \
          eq("use collection parameter :product with matching " \
             "#initialize(product:, product_counter:, product_iteration:" \
             "[, ...]) keyword arguments")
      end
    end
  end

  describe "#failure_message" do
    subject { red_matcher.tap { |m| m.matches?(ProductComponent) }.failure_message }

    it do
      is_expected.to \
        eq("expected ProductComponent to use collection parameter " \
           ":user with matching #initialize(user:[, ...]) keyword argument")
    end
  end

  describe "#failure_message_when_negated" do
    subject { red_matcher.tap { |m| m.matches?(ProductComponent) }.failure_message_when_negated }

    it do
      is_expected.to \
        eq("expected ProductComponent not to use collection parameter " \
           ":user with matching #initialize(user:[, ...]) keyword argument")
    end
  end
end
