class ApplicationController < ActionController::Base
  def about
    about = {}
    about[:credentials] = Rails.application.credentials.config.sort.to_h
    about[:environment_variables] = ENV.sort.to_h

    # Removing filtering, since this is a sample app and this info may be helpful. Leaving the idea here in case we realise we need it.
    # @filtered_about = {}
    # about.each do |key, value| 
    #   if Rails.application.config.filter_parameters.any? {|filter_regex| key =~ Regexp.new(filter_regex.to_s) }
    #     @filtered_about[key] = "REDACTED"
    #   else
    #     @filtered_about[key] = value
    #   end
    # end

    @about = about
  end

  def credentials
    credentials_dir = Rails.root.join('config')
    credential_files_grep = '**/*.yml.enc'
    
    credential_files = Dir.glob(credentials_dir.join(credential_files_grep))
    
    credential_file_contents = {}
    credential_files.each do |cred_file|
      credentials = ActiveSupport::EncryptedFile.new(
        content_path: cred_file,
        key_path: cred_key_file(cred_file),
        env_key: "RAILS_MASTER_KEY", 
        raise_if_missing_key: true
      )
      credential_file_contents[cred_file] = credentials.read
    end

    @credentials = Rails.application.credentials.config.sort.to_h
    @credential_file_contents = credential_file_contents
  end

  private

  def cred_key_file(cred_file)
    case File.basename(cred_file)
    when 'credentials.yml.enc'
      cred_file.gsub('credentials.yml.enc', 'master.key')
    else
      cred_file.gsub('.yml.enc', '.key')
    end
  end

end
