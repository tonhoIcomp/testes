import express from 'express';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Rota para exibir um formulário HTML
app.get('/createClient', (req, res) => {
  res.sendFile(__dirname + '/createClient.html');
});

// Rota para exibir um formulário HTML
app.get('/createCategoria', (req, res) => {
  res.sendFile(__dirname + '/createCategoria.html');
});


// Rota para processar o envio do formulário
app.post('/createClient', async (req, res) => {
  const { nome_completo, cpf, numero_celular, email, data_nascimento } = req.body;
  const novoCliente = await prisma.cliente.create({
    data: {
      nome_completo,
      cpf,
      numero_celular,
      email,
      data_nascimento: new Date(data_nascimento),
    },
  });
  res.json(novoCliente);
});



// Outras rotas para listar, atualizar e excluir clientes

// Rota para listar todos os clientes
app.get('/list', async (req, res) => {
    const clientes = await prisma.cliente.findMany();
    res.json(clientes);
  });
  
// Rota para atualizar um cliente pelo ID
app.put('/update/:id', async (req, res) => {
    const { id } = req.params;
    const { nome_completo, cpf, numero_celular, email, data_nascimento } = req.body;
  
    const cliente = await prisma.cliente.update({
      where: { cliente_id: parseInt(id) },
      data: {
        nome_completo,
        cpf,
        numero_celular,
        email,
        data_nascimento: new Date(data_nascimento),
      },
    });
  
    res.json(cliente);
  });

// Rota para excluir um cliente pelo ID
app.delete('/delete/:id', async (req, res) => {
    const { id } = req.params;
  
    const cliente = await prisma.cliente.delete({
      where: { cliente_id: parseInt(id) },
    });
  
    res.json({ message: 'Cliente excluído com sucesso', cliente });
  });
  
  

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor em execução na porta ${PORT}`);
});
