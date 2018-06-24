module Jobs
  class SendAutoResponderMessage < Jobs::Base
    def execute(args)
      if receiver = User.find_by(id: args[:user_id])
        sender = current_user
        topic_id = args[:topic_id]
        post_number = args[:post_number]

        post = PostCreator.create!(
          sender,
          raw: "this is a test message",
          topic_id: topic_id,
          reply_to_post_number: post_number
        )

      end
    end
  end
end
