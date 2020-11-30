RailsAdmin.config do |config|

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  # == CancanCan ==
  config.authorize_with :cancancan
  config.parent_controller = 'ApplicationController'

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.main_app_name = ["Lums", "BackOffice"]
  config.included_models = ["User", "Course" ]

  config.model 'User' do
    object_label_method do
      :user_custom_label_method
    end
    list do
      field :email
      field :firstname
      field :lastname
      field :courses_enrolled
    end

    edit do 
      field :courses_enrolled
    end
    
    show do 
      field :email
      field :firstname
      field :lastname
      field :courses_enrolled
    end
  end

  config.model 'Course' do 
    object_label_method do
      :course_custom_label_method
    end
    list do
      field :title
      field :student_count
    end

    edit do
      field :title
      field :image
    end
  end

  def user_custom_label_method
    self.email
  end

  def course_custom_label_method
    self.title.split(":").first
  end
end

