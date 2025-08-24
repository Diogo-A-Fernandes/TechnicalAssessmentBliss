# Bliss Recruitment iOS Challenge  

This project was developed as part of the **Bliss Applications Recruitment Challenge for iOS**.  
The goal was to design a **simple and interactive iOS app** that consumes GitHub’s public API while applying good development practices in Swift.

---

##  English

### 📌 Features Implemented
1. **Emoji Fetching & Caching**  
   - Retrieves emojis from GitHub API (`/emojis` endpoint).  
   - Data persisted locally using **Core Data** (or similar storage).  
   - API requests optimized with cache-first strategy to reduce unnecessary calls.

2. **Random Emoji Display**  
   - A button that displays a random emoji each time it is pressed.  

3. **Emoji List**  
   - Displays all stored emojis in a grid layout.  
   - Allows removal of an item from memory (not from cache).  
   - Pull-to-Refresh reinitializes the full list.

4. **User Avatar Search**  
   - Search GitHub users by username (`/users/:username`).  
   - Fetches and stores avatar images locally.  
   - Includes cache-first logic to avoid redundant API requests.

5. **Avatar List**  
   - Shows all saved user avatars in a list.  
   - Supports deletion from the database.  

6. **Apple Repositories**  
   - Lists Apple’s GitHub repositories (`/users/apple/repos`).  
   - Implemented with **pagination** (10 repos per request, load more on scroll).  

---

### 🛠️ Tech Stack
- **Language**: Swift  
- **IDE**: Xcode  
- **Architecture**: Modular approach with reusable components  
- **Persistence**: Core Data (for caching emojis and avatars)  
- **Networking**: URLSession (REST API calls to GitHub)  
- **Version Control**: Git (Git Flow branching model encouraged)  

---

### 🚀 How to Run
1. Clone the repository.  
2. Open the project in **Xcode**.  
3. Run the app on a simulator or physical device.  
4. Explore the features: fetching emojis, searching avatars, listing repositories, etc.  

---

##  Português

### 📌 Funcionalidades Implementadas
1. **Recolha e Cache de Emojis**  
   - Obtém emojis da API do GitHub (`/emojis`).  
   - Os dados são guardados localmente usando **Core Data**.  
   - Lógica de cache para evitar chamadas desnecessárias à API.  

2. **Exibição de Emoji Aleatório**  
   - Botão que apresenta um emoji aleatório a cada clique.  

3. **Lista de Emojis**  
   - Mostra todos os emojis guardados em grelha.  
   - Permite remover um item apenas da memória (não do cache).  
   - Pull-to-Refresh para repor a lista completa.  

4. **Pesquisa de Avatares de Utilizadores**  
   - Pesquisa utilizadores do GitHub pelo nome (`/users/:username`).  
   - Obtém e guarda as imagens de avatar localmente.  
   - Inclui lógica de cache para evitar chamadas redundantes.  

5. **Lista de Avatares**  
   - Apresenta todos os avatares guardados.  
   - Permite eliminar diretamente da base de dados.  

6. **Repositórios da Apple**  
   - Lista os repositórios públicos da Apple (`/users/apple/repos`).  
   - Implementado com **paginação** (10 repositórios por pedido, carregando mais ao fazer scroll).  

---

### 🛠️ Tecnologias Utilizadas
- **Linguagem**: Swift  
- **IDE**: Xcode  
- **Arquitetura**: Estrutura modular com componentes reutilizáveis  
- **Persistência**: Core Data (para cache de emojis e avatares)  
- **Networking**: URLSession (chamadas REST à API do GitHub)  
- **Controlo de Versão**: Git (modelo Git Flow recomendado)  

---

### 🚀 Como Executar
1. Clonar o repositório.  
2. Abrir o projeto no **Xcode**.  
3. Executar a app num simulador ou dispositivo físico.  
4. Explorar as funcionalidades: recolha de emojis, pesquisa de avatares, listagem de repositórios, etc.  

---
