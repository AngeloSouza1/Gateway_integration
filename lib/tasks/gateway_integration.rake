namespace :gateway do
  desc "Automatiza a integração de um novo gateway"
  task integrate: :environment do
    gateway_name = ENV['GATEWAY_NAME'] || 'FastPay'
    slug = gateway_name.parameterize.underscore
    migration_name = "create_#{slug}_configs"
    migration_path = "db/migrate/*_#{migration_name}.rb"

    puts "🚀 Iniciando automação para o gateway: #{gateway_name}"

    # 1. Verificar e Criar a Migration
    if Dir.glob(migration_path).any?
      puts "⚠️ Migração já existe: #{Dir.glob(migration_path).first}"
    else
      system("rails generate migration #{migration_name}")
      migration_file = Dir.glob("db/migrate/*_#{migration_name}.rb").first

      if migration_file
        puts "✅ Migration criada: #{migration_file}"
        File.open(migration_file, 'w') do |file|
          file.write <<~MIGRATION
            class #{migration_name.camelcase} < ActiveRecord::Migration[7.0]
              def change
                create_table :#{slug}_configs do |t|
                  t.boolean :active, default: true
                  t.boolean :capture, default: false
                  t.datetime :deleted_at
                  t.boolean :has_rate, default: false
                  t.integer :installments
                  t.string :name
                  t.string :name_invoice
                  t.decimal :rate, precision: 19, scale: 2
                  t.string :public_key
                  t.string :secret_key
                  t.string :production_url, default: 'https://api.#{slug}.com'
                  t.string :sandbox_url, default: 'https://sandbox.api.#{slug}.com'
                  t.string :slug
                  t.string :statement_descriptor
                  t.references :client, null: true, foreign_key: true
                  t.references :store, null: false, foreign_key: true
                  t.timestamps
                end

                add_column :clients, :has_#{slug}, :boolean, default: false
              end
            end
          MIGRATION
        end
      else
        puts "❌ Erro ao criar a migração. Processo cancelado."
        exit
      end
    end

    # 2. Verificar e Criar o Model
    model_path = "app/models/#{slug}_config.rb"
    if File.exist?(model_path)
      puts "⚠️ Modelo já existe: #{model_path}"
    else
      File.open(model_path, 'w') do |file|
        file.write <<~MODEL
          class #{gateway_name.camelcase}Config < ApplicationRecord
            belongs_to :client, optional: true
            belongs_to :store

            validates :store, uniqueness: true
            validates :public_key, presence: true
            validates :secret_key, presence: true
          end
        MODEL
      end
      puts "✅ Modelo criado: #{model_path}"
    end

    # 3. Verificar e Criar o Controller
    controller_path = "app/controllers/api/v1/webhook/#{slug}/payments_controller.rb"
    if File.exist?(controller_path)
      puts "⚠️ Controller já existe: #{controller_path}"
    else
      FileUtils.mkdir_p(File.dirname(controller_path))
      File.open(controller_path, 'w') do |file|
        file.write <<~CONTROLLER
          class Api::V1::Webhook::#{gateway_name.camelcase}::PaymentsController < ApiController
            skip_before_action :authenticate_request

            def update
              # Lógica do webhook
              render json: { message: 'ok' }
            end
          end
        CONTROLLER
      end
      puts "✅ Controller criado: #{controller_path}"
    end

    # 4. Adicionar Rotas
    routes_path = "config/routes/api_routes.rb"
    routes_snippet = <<~ROUTES

      namespace :#{slug} do
        get 'payments', to: 'payments#update'
        post 'payments', to: 'payments#update'
      end
    ROUTES
    if File.read(routes_path).include?("namespace :#{slug}")
      puts "⚠️ Rotas para #{slug} já existem em #{routes_path}"
    else
      File.open(routes_path, 'a') { |file| file.puts routes_snippet }
      puts "✅ Rotas adicionadas no arquivo: #{routes_path}"
    end

    # 5. Verificar e Criar a View
    view_path = "app/views/store/gateways/_#{slug}_config.html.erb"
    if File.exist?(view_path)
      puts "⚠️ View já existe: #{view_path}"
    else
      File.open(view_path, 'w') do |file|
        file.write <<~VIEW
          <div>
            <h2>Configuração do Gateway #{gateway_name}</h2>
            <form>
              <input type="text" placeholder="Chave Pública" name="public_key">
              <input type="password" placeholder="Chave Secreta" name="secret_key">
              <button type="submit">Salvar</button>
            </form>
          </div>
        VIEW
      end
      puts "✅ View de configuração criada: #{view_path}"
    end

    # 6. Verificar e Criar o Placeholder de Logo
    logo_path = "app/assets/images/gateway_images/#{slug}.png"
    if File.exist?(logo_path)
      puts "⚠️ Placeholder de logo já existe: #{logo_path}"
    else
      FileUtils.touch(logo_path)
      puts "✅ Placeholder de logo criado: #{logo_path}"
    end

    # 7. Aplicar Migrações
    puts "✅ Aplicando migrações..."
    system("rails db:migrate")

    puts "🎉 Automação concluída para o gateway: #{gateway_name}!"
  end
end
