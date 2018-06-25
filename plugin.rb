# name: procourse-autoresponder
# about: Set dates and times for sending automatic responses to Discourse group messages.
# version: 1.0
# authors: Procourse
# url: https://github.com/procourse/procourse-autoresponder

enabled_site_setting :autoresponder_enabled
require 'date'

after_initialize do
  require_dependency File.expand_path('../app/jobs/regular/send_autoresponder_message.rb', __FILE__)
  require_dependency 'discourse_event'

  # Add custom user preference for setting
  User.register_custom_field_type('autoresponder_start_date', :date)
  User.register_custom_field_type('autoresponder_end_date', :date)
  User.register_custom_field_type('autoresponder_message', :text)
  User.register_custom_field_type('autoresponder_groups', :text)


  public_user_custom_fields = SiteSetting.public_user_custom_fields.split('|')
  public_user_custom_fields.push('autoresponder_start_date')
  public_user_custom_fields.push('autoresponder_end_date')
  public_user_custom_fields.push('autoresponder_message')
  public_user_custom_fields.push('autoresponder_groups')
  SiteSetting.public_user_custom_fields = public_user_custom_fields.join('|')

  DiscourseEvent.on(:post_created) do |post,opts|
    if SiteSetting.autoresponder_enabled?
      users = post.topic.topic_allowed_users.to_a
      if post.topic.archetype == "private_message" && users.length == 2
        if users[0].user_id != post.user_id
          user = User.find_by(id: users[0].user_id)
        else
          user = User.find_by(id: users[0].user_id)
        end
        start_date = DateTime.parse(user.custom_fields["autoresponder_start_date"]) if user.custom_fields["autoresponder_start_date"]
        end_date = DateTime.parse(user.custom_fields["autoresponder_end_date"]) if user.custom_fields["autoresponder_end_date"]

        Jobs.enqueue(
          :send_autoresponder_message,
          topic_id: post.topic_id,
          user: user,
          post_number: post.post_number,
        )
      end
    end
  end
end
