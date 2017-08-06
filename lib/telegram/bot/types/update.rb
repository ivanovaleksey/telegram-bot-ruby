module Telegram
  module Bot
    module Types
      class Update < Base
        attribute :update_id, Integer
        attribute :message, Message
        attribute :edited_message, Message
        attribute :channel_post, Message
        attribute :edited_channel_post, Message
        attribute :inline_query, InlineQuery
        attribute :chosen_inline_result, ChosenInlineResult
        attribute :callback_query, CallbackQuery
        attribute :shipping_query, ShippingQuery
        attribute :pre_checkout_query, PreCheckoutQuery

        def extract_message
          types = %w(
            inline_query
            chosen_inline_result
            callback_query
            edited_message
            message
            channel_post
            edited_channel_post
          )
          types.inject(nil) { |acc, elem| acc || public_send(elem) }
        end
      end
    end
  end
end
