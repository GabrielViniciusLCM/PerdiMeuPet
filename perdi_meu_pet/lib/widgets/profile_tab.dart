import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // TODO: Botão para editar perfil (ainda não implementado)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Editar perfil ainda não implementado')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, size: 50, color: Colors.grey.shade700),
            ),
            SizedBox(height: 20),
            Text(
              'Nome do Usuário',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'usuario@email.com',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            SizedBox(height: 5),
            Text(
              '+55 11 99999-9999',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            SizedBox(height: 20),
            Divider(thickness: 1.5),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.teal),
              title: Text('Configurações'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Configurações ainda não implementadas')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.teal),
              title: Text('Sair'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // TODO: Implementar logout
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout ainda não implementado')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
