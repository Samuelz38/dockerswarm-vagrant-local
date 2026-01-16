

# Cluster Docker Swarm Automatizado com Vagrant

Este projeto automatiza a criação de um ambiente de infraestrutura escalável utilizando **Vagrant** e **Docker Swarm**. Através de scripts Shell e um Vagrantfile customizado, o sistema provisiona 4 Máquinas Virtuais (VMs) Ubuntu, instala as dependências necessárias e configura um cluster orquestrado de forma totalmente automática. 

## Tecnologias Utilizadas


* **Vagrant**: Gerenciamento e automação de ambientes virtuais. 
* **VirtualBox**: Hypervisor para execução das VMs.
* **Docker & Docker Swarm**: Containerização e orquestração em cluster. 
* **Shell Script**: Automação do provisionamento e configuração do sistema. 
* **Ubuntu 22.04 (Bento)**: Sistema operacional base das máquinas do cluster. 



## Arquitetura do Cluster

O ambiente é composto por 4 nós com IPs estáticos definidos na rede privada: 

| Máquina | Função | IP (Rede Privada) | Recursos (RAM/CPU) |
| --- | --- | --- | --- |
| **master** | Manager | `192.168.56.10` | 512MB / 1 vCPU |
| **node01** | Worker | `192.168.56.11` | 512MB / 1 vCPU |
| **node02** | Worker | `192.168.56.12` | 512MB / 1 vCPU |
| **node03** | Worker | `192.168.56.13` | 512MB / 1 vCPU |

> [!IMPORTANT]
> A configuração de hardware das máquinas (Memória e CPU) e a imagem utilizada (`bento/ubuntu-22.04`) são definidas dinamicamente no arquivo `Vagrantfile`. 
> 


## Como Executar

Para subir o cluster completo, siga os passos abaixo no seu terminal Ubuntu:

1. **Clone o repositório:**
```bash
git clone https://github.com/seu-usuario/nome-do-repo.git
cd nome-do-repo

```


2. **Dê permissão de execução aos scripts:**
```bash
chmod +x configs.sh installdocker.sh

```


3. **Inicie a automação:**
```bash
./configs.sh

```



## O que o script de automação faz?

O script `configs.sh` executa as seguintes etapas: 

* **Atualização do Host**: Atualiza os pacotes do servidor principal. 
* **Instalação de Dependências**: Instala o VirtualBox e o Vagrant (via repositório oficial HashiCorp). 
* **Provisionamento (Vagrant Up)**: Dispara a criação das 4 VMs. 
* **Instalação do Docker**: Cada VM executa o script `installdocker.sh` durante o boot. 
* **Configuração do Swarm**:
  * Inicializa o nó **master** como `manager`. 
  * Captura o `token` de autenticação. 
  * Faz o `join` automático dos nós **node01, node02 e node03** como `workers`. 





## Verificação

Após o término, você pode validar o cluster acessando a máquina master:

```bash
vagrant ssh master -c "docker node ls"

```
