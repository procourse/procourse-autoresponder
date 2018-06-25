module Jobs
  class SendAutoresponderMessage < Jobs::Base
    def execute(args)
      if sender = args[:user]
        topic_id = args[:topic_id]
        post_number = args[:post_number]
        message = sender.custom_fields["autoresponder_message"]
        post = PostCreator.create!(
          sender,
          raw: message,
          topic_id: topic_id,
          reply_to_post_number: post_number
        )
      end
    end
  end
  end
