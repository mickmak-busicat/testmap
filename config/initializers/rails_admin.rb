RailsAdmin.config do |config|

  ### Popular gems integration
  config.authenticate_with do
    name = ENV['FLOORNOTE_ADMIN_USERNAME']
    pass = ENV['FLOORNOTE_ADMIN_PASSWORD']
    if ENV['RAILS_ENV'] != 'production'
      name = 'admin'
      pass = '1234'
    end
    authenticate_or_request_with_http_basic('Login to continue') do |username, password|
      username == name && password == pass
    end
  end

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    root :building_import

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # config.model 'Building' do
  #   object_label_method do
  #     :custom_building_label_method
  #   end
  # end

  config.model 'BuildingSession' do
    configure :created_at, :datetime do
      strftime_format '%Y-%m-%d %H:%M:%S'
    end
    configure :updated_at, :datetime do
      strftime_format '%Y-%m-%d %H:%M:%S'
    end
  end

  config.model 'Rate' do
    configure :created_at, :datetime do
      strftime_format '%Y-%m-%d %H:%M:%S'
    end
    configure :updated_at, :datetime do
      strftime_format '%Y-%m-%d %H:%M:%S'
    end
  end

  config.model 'Membership' do
    object_label_method do
      :custom_membership_label_method
    end
  end

  config.model 'Floor' do
    object_label_method do
      :custom_floor_label_method
    end
  end

  config.model 'User' do
    object_label_method do
      :custom_user_label_method
    end
    configure :expires_at, :datetime do
      strftime_format '%Y-%m-%d %H:%M:%S'
    end
    configure :created_at, :datetime do
      strftime_format '%Y-%m-%d %H:%M:%S'
    end
    configure :updated_at, :datetime do
      strftime_format '%Y-%m-%d %H:%M:%S'
    end
    configure :last_confirmation_sent, :datetime do
      strftime_format '%Y-%m-%d %H:%M:%S'
    end
  end

  def custom_user_label_method
    "#{self.email}"
  end

  config.model 'FloorObject' do
    object_label_method do
      :custom_floor_object_label_method
    end
  end

  def custom_membership_label_method
    "#{self.membership_id}"
  end

  def custom_floor_object_label_method
    if !self.floor.nil? && !self.floor.building.nil?
      label = self.id
      label = self.label if !self.label.nil?
      "#{self.floor.building.name}(#{self.floor.name})[#{label}]"
    else
      "#{self.object_type} #{self.id}"
    end
  end

  def custom_floor_label_method
    if self.building.nil?
      "NONE (#{self.name})"
    else
      "#{self.building.name}(#{self.name})"
    end
  end

end
