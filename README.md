# Integração de Gateways

Este repositório implementa a integração de gateways de pagamento de forma automatizada utilizando tasks no Rails.

---

## 1. Cadastro de Gateway

Os dados básicos de cada gateway são cadastrados via interface no sistema.

### Passos para Cadastrar um Novo Gateway:
1. Acesse o sistema na rota: `/gateways/new`.
2. Preencha os seguintes campos:
   - **Nome do Gateway**: Nome identificador do gateway (ex: MegaPay).
   - **URL de Produção**: URL para operações em produção (ex: `https://api.megapay.com`).
   - **URL de Sandbox**: URL para operações de teste (ex: `https://sandbox.api.megapay.com`).
   - **Chave Pública**: Chave fornecida pelo gateway (ex: `pk_test_megapay_123456`).
   - **Chave Secreta**: Chave fornecida pelo gateway (ex: `sk_test_megapay_abcdef`).
   - **Ativo**: Marque como ativo para habilitar o gateway.
3. Clique em **Salvar**.

---

## 2. Automação de Arquivos do Gateway

Após cadastrar o gateway no sistema, utilize a task para gerar os arquivos necessários.

### Passos para Executar a Task:
1. No terminal, execute o comando:
   ```bash
   rake gateway:integrate GATEWAY_NAME="NOME_DO_GATEWAY"

### Substitua `NOME_DO_GATEWAY` pelo nome cadastrado, como `MegaPay`.

A task criará automaticamente:
- **Migração**: Para a tabela de configurações do gateway.
- **Modelo**: Arquivo no diretório `app/models`.
- **Controller**: Para Webhooks no diretório `app/controllers/api/v1/webhook`.
- **Rotas**: Adicionadas em `config/routes/api_routes.rb`.
- **View**: Formulário de configuração em `app/views/store/gateways`.
- **Placeholder de Logo**: Arquivo em `app/assets/images/gateway_images`.

A task também aplicará as migrações geradas.

---

### 3. Testar o Gateway

#### Simulação de Pagamento
1. Crie um pedido no sistema utilizando o gateway configurado.
2. Complete o fluxo de pagamento.

#### Testar Webhooks
1. Use `ngrok` para expor seu ambiente local:
   ```bash
   ngrok http 3000
### Configure o Webhook no painel do gateway com o URL gerado:

- **Exemplo**: `https://<seu-ngrok>.ngrok.io/api/v1/webhook/megapay/payments`.

Envie notificações de teste pelo painel do gateway e monitore os logs:

```bash
tail -f log/development.log
```
---

### 4. Estrutura do Repositório

- **`app/models`**: Modelos para configurações dos gateways.
- **`app/controllers/api/v1/webhook`**: Controllers para lidar com notificações de Webhooks.
- **`config/routes/api_routes.rb`**: Rotas específicas para Webhooks.
- **`app/views/store/gateways`**: Formulários de configuração.
- **`app/assets/images/gateway_images`**: Logos dos gateways.
- **`db/migrate`**: Migrações para tabelas relacionadas aos gateways.
