// cliente.ts
document.getElementById('clienteForm')?.addEventListener('submit', async (e) => {
    e.preventDefault();
  
    const nome_completo = (document.getElementById('nome_completo') as HTMLInputElement).value;
    const cpf = (document.getElementById('cpf') as HTMLInputElement).value;
    const numero_celular = (document.getElementById('numero_celular') as HTMLInputElement).value;
    const email = (document.getElementById('email') as HTMLInputElement).value;
    const data_nascimento = (document.getElementById('data_nascimento') as HTMLInputElement).value;
  
    const response = await fetch('/api/clientes', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        nome_completo,
        cpf,
        numero_celular,
        email,
        data_nascimento,
      }),
    });
  
    if (response.ok) {
      const data = await response.json();
      console.log('Cliente cadastrado com sucesso:', data);
    } else {
      console.error('Erro ao cadastrar o cliente.');
    }
  });
  