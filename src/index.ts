import { PrismaClient } from "@prisma/client";
import express from 'express';

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

// Rota para servir o formulário HTML
  app.get('/api/clientes', (req, res) => {
  res.sendFile(__dirname + '/index.html'); // Altere o caminho para o seu arquivo HTML
});


// Rotas para criar um novo Cliente
app.post('/api/clientes', async (req, res) => {
    try {
      const { nome_completo, cpf, numero_celular, email, data_nascimento } = req.body;
      const cliente = await prisma.cliente.create({
        data: { nome_completo, cpf, numero_celular, email, data_nascimento },
      });
      res.json(cliente);
    } catch (error) {
      res.status(500).json({ error: 'Erro ao criar um cliente.' });
    }
  });

// Rotas para outras operações CRUD (atualizar, excluir, listar) para todas as entidades
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
        
