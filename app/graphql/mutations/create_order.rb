module Mutations
  class CreateOrder < BaseMutation
    argument :description, String, required: true
    argument :total, Float, required: true

    field :order, Types::OrderType, null: false
    field :errors, [String], null: false

    def resolve(description:, total:)
      order = Order.new(description: description, total: total)

      if order.save
        {
          order: order,
          errors: []
        }
      else
        {
          order: nil,
          error: order.errors.full_messages
        }
      end
    end
  end
end