<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
  <h1>Infraestrutura para Site de Hamburgueria com AWS e Terraform 🍔</h1>

  <p>
    Este projeto demonstra como criar uma infraestrutura básica na Amazon Web Services (AWS) utilizando 
    <strong>Terraform</strong> para hospedar um site estático que simula uma página de hamburgueria com 
    um formulário de pedidos.
  </p>

  <hr>

  <h2>📋 Etapas do Projeto</h2>

  <h3>1️⃣ Configuração da Infraestrutura com Terraform</h3>
  <ul>
    <li><strong>VPC (Virtual Private Cloud):</strong> Para isolar nossa infraestrutura.</li>
    <li><strong>Subnets Públicas e Privadas:</strong> Para organizar o tráfego.</li>
    <li><strong>Instância EC2:</strong> Para hospedar o site.</li>
    <li><strong>Banco de Dados MySQL:</strong> Para armazenar as informações dos pedidos.</li>
    <li>
      <strong>Grupo de Segurança (Security Group):</strong> Configurado para permitir todo o tráfego 
      <em>(não recomendado para produção)</em>. Você pode ajustar as configurações no código conforme necessário.
    </li>
  </ul>

  <h3>2️⃣ Criação do Backend com Python (Flask)</h3>
  <p>
    Desenvolvemos uma aplicação <strong>Flask</strong> simples para o backend:
  </p>
  <ul>
    <li>O backend recebe os pedidos feitos na página e os armazena no banco de dados MySQL.</li>
    <li>O código é executado na instância EC2, que conecta o aplicativo Flask ao banco de dados.</li>
  </ul>

  <h3>3️⃣ Desenvolvimento da Página Web (HTML/CSS)</h3>
  <ul>
    <li>Criamos uma interface de frontend funcional e simples:</li>
    <li>Contém um formulário para inserir o nome do cliente e selecionar os hambúrgueres desejados.</li>
    <li>Comunica-se com o backend para enviar os dados do pedido.</li>
  </ul>

  <h3>4️⃣ Configuração do Banco de Dados MySQL</h3>
  <p>
    Criamos uma tabela <code>pedidos</code> para armazenar os dados dos pedidos:
  </p>
  <pre>
<code>CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100),
    burguer VARCHAR(100),
    quantidade INT
);</code>
  </pre>
  <p>A tabela armazena informações como nome do cliente, hambúrguer selecionado e quantidade.</p>

  <hr>

  <h2>🚀 Resultado</h2>
  <p>
    Uma aplicação completa com <strong>frontend e backend</strong>:
  </p>
  <ul>
    <li>O formulário de pedidos no frontend envia os dados para o backend Flask.</li>
    <li>O backend processa os dados e os armazena no banco de dados MySQL.</li>
  </ul>

  <hr>

  <p>
    Sinta-se à vontade para clonar este repositório e personalizá-lo conforme suas necessidades.
  </p>
  <p>
    <strong><a href="https://www.linkedin.com/posts/vinicius-marssoy_fala-rede-neste-post-vou-compartilhar-activity-7264328990557970434-P5aa?utm_source=share&utm_medium=member_desktop" target="_blank">
    </a>Clique aqui para assistir o vídeo do passo a passo que postei no LinkedIn</strong>
  </p>

  <p>Espero que seja útil! 😄</p>
</body>
</html>
