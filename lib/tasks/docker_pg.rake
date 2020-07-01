namespace :docker do
  namespace :pg do
    config   = Rails.configuration.database_configuration
    database = config[Rails.env]["database"]
    username = config[Rails.env]["username"]
    password = config[Rails.env]["password"]
    port = config[Rails.env]["port"]
    name = database
    path = '$HOME/docker/volumes/' + name

    desc "Craete Dockerized postgreSQL volume"
    task init: :environment do
      mkdir = "mkdir -p #{path}"
      run_bash(mkdir)
      run_bash("ls -la #{path}")
    end

    desc "Run Dockerized postgreSQL"
    task run: :environment do
      postgresql_cmd = """
      [[ $(docker ps --filter \"name=^/#{name}\" --format '{{.Names}}') == #{name} ]] || \
      docker run --rm --name #{name} \
      -v #{path}:/var/lib/postgresql/data \
      -e POSTGRES_DB=#{database} \
      -e POSTGRES_USER=#{username} \
      -e POSTGRES_PASSWORD=#{password} \
      -p #{port}:5432 -d postgres
      """
      run_bash postgresql_cmd
    end
  end

  def run_bash cmd
    system("echo \"#{cmd}\"")
    system("bash -c #{cmd.shellescape}")
  end
end
