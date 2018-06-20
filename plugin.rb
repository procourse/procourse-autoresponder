# name: procourse-autoresponder
# about: Set dates and times for sending automatic responses to Discourse group messages.
# version: 1.0
# authors: Procourse
# url: https://github.com/procourse/procourse-autoresponder

enabled_site_setting :autoresponder_enabled

after_initialize do
# Add custom user preference for setting
User.register_custom_field_type('autoresponder_start_date', :date)
User.register_custom_field_type('autoresponder_end_date', :date)

public_user_custom_fields = SiteSetting.public_user_custom_fields.split('|')
public_user_custom_fields.push('autoresponder_start_date')
public_user_custom_fields.push('autoresponder_end_date')
SiteSetting.public_user_custom_fields = public_user_custom_fields.join('|')

end
