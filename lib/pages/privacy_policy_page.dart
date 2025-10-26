import 'package:camarim_backend/pages/customer/menu_page.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final String customerId = "";
  bool concordo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF626BBA)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'lib/assets/img/logo.png',
          width: 180,
          height: 50,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            const Text(
              "Termos de Uso e Política de Privacidade",
              style: TextStyle(
                color: Color(0xFF626BBA),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF626BBA)),
                ),
                child: const SingleChildScrollView(
                  child: Text(
                    '''TERMO DE USO DO SISTEMA "CAMARIM"

Este Termo de Uso ("Termo") é um acordo legal entre você, o(a) usuário(a) do sistema, e os desenvolvedores do projeto "Camarim" (doravante denominado "Camarim" ou "Nós"), um sistema desenvolvido para buscar profissionais da área de estética, encontrar e agendar serviços, permitir avaliações e conectar profissionais cadastrados a clientes, mediante cobrança de taxa pelos serviços contratados dentro da plataforma.

Ao acessar ou utilizar o Camarim, você declara ter lido, compreendido e aceitado integralmente este Termo de Uso, bem como nossa Política de Privacidade e a Lei Geral de Proteção de Dados Pessoais (LGPD – Lei nº 13.709/2018). Caso você não concorde com estes termos, não deverá utilizar o sistema.

CLÁUSULA PRIMEIRA – DAS CONDIÇÕES GERAIS DE USO
O Camarim é destinado a conectar clientes a profissionais da área de estética, permitindo busca de serviços, agendamento, avaliação, interação, troca de informações e contratação dos profissionais cadastrados, mediante regras e taxas previstas pelo sistema.

CLÁUSULA SEGUNDA – DA COLETA E USO DE DADOS PESSOAIS
O usuário declara estar ciente de que o Camarim coleta e armazena os seguintes dados pessoais, quando informados:
- Nome completo
- E-mail
- Telefone
- Senha
- CPF
- Endereço
- Gênero
- Dados de pagamento
- Endereço IP e logs de acesso
- Foto de perfil (se enviada)
- Arquivos ou informações enviadas pelo usuário na plataforma

CLÁUSULA TERCEIRA – FINALIDADE DA COLETA
A coleta e o tratamento dos dados pessoais têm as seguintes finalidades essenciais:
- Criar e gerenciar a conta do usuário
- Permitir contato entre cliente e profissional
- Viabilizar agendamentos
- Garantir segurança e autenticação de acesso
- Executar pagamentos e repassar valores aos profissionais
- Enviar notificações e comunicações sobre o uso da plataforma
- Disponibilizar arquivos ou conteúdos enviados pelo usuário
- Cumprir obrigações legais e regulatórias

CLÁUSULA QUARTA – VEDAÇÕES DE USO
O usuário se compromete a não utilizar o Camarim para qualquer finalidade ilícita, antiética ou que viole este Termo, incluindo, mas não se limitando a:
- Publicar conteúdo ilegal, ofensivo, difamatório, obsceno ou prejudicial
- Tentar invadir, alterar ou danificar contas de outros usuários
- Fraudar pagamentos, avaliações ou identidade
- Violar direitos autorais, de imagem ou outros direitos de terceiros

CLÁUSULA QUINTA – ACEITAÇÃO IMPLÍCITA
A utilização do Camarim implica na aceitação plena e irrestrita deste Termo de Uso.

CLÁUSULA SEXTA – DA PROTEÇÃO DOS DADOS
O Camarim compromete-se a adotar medidas técnicas e administrativas de segurança, em conformidade com a LGPD e boas práticas baseadas nas normas ISO/IEC 27001, 27701 e 29100, incluindo:
- Criptografia de informações sensíveis
- Autenticação segura e controle de acesso
- Banco de dados com restrição de permissões
- Plano de resposta a incidentes de segurança

CLÁUSULA SÉTIMA – DO COMPARTILHAMENTO DE DADOS
Os dados pessoais não serão compartilhados com terceiros, exceto:
- Quando houver autorização do usuário
- Em cumprimento de ordem judicial ou obrigação legal
- Para serviços técnicos indispensáveis ao funcionamento do sistema (ex.: meios de pagamento)

CLÁUSULA OITAVA – DOS DIREITOS DO TITULAR DOS DADOS
Nos termos da LGPD, o usuário poderá, a qualquer momento:
- Solicitar informações sobre o uso de seus dados
- Corrigir informações incompletas ou desatualizadas
- Revogar consentimento
- Solicitar exclusão da conta e dos dados, quando permitido por lei
Canal oficial de contato: contact.camarim@gmail.com

CLÁUSULA NONA – DO RESPONSÁVEL PELO TRATAMENTO DOS DADOS (DPO)
Caio Martins Caldeira – Desenvolvedor Front-end / Encarregado de Dados (DPO)

CLÁUSULA DÉCIMA – DA EXATIDÃO DOS DADOS
O usuário é o único responsável pela veracidade e atualização das informações fornecidas. O Camarim não se responsabiliza por dados falsos, incorretos ou incompletos inseridos pelo usuário.

CLÁUSULA DÉCIMA PRIMEIRA – DA TRANSPARÊNCIA
O Camarim garante transparência no tratamento de dados pessoais. As solicitações serão respondidas em até 48 horas para confirmações simples e em até 15 dias para demandas complexas.

CLÁUSULA DÉCIMA SEGUNDA – DADOS DE CRIANÇAS E ADOLESCENTES
O tratamento de dados de menores seguirá o art. 14 da LGPD:
- Coleta de dados de crianças apenas com consentimento dos responsáveis
- Tratamento de dados de adolescentes visando sempre o melhor interesse
- Controles adicionais de segurança e confidencialidade

CLÁUSULA DÉCIMA TERCEIRA – ATUALIZAÇÕES DO TERMO
Este Termo poderá ser atualizado periodicamente em razão de mudanças legais, técnicas ou operacionais.

CLÁUSULA DÉCIMA QUARTA – DO FORO
Fica eleito o foro da comarca de Belo Horizonte/MG para dirimir quaisquer controvérsias.

Belo Horizonte/MG, ____ de __________ de 2025.

USUÁRIO(A):
Nome completo - CPF

PELO PROJETO "CAMARIM":
Caio Martins Caldeira - Encarregado de Dados (DPO)

TESTEMUNHAS:
________________________________________ - Nome completo / CPF
________________________________________ - Nome completo / CPF

TERMO DE CONSENTIMENTO PARA TRATAMENTO DE DADOS PESSOAIS – “CAMARIM”

Este Termo formaliza sua autorização expressa, livre, informada e inequívoca para o tratamento de seus dados pessoais pelo Projeto “CAMARIM” (doravante denominado “Camarim” ou “Nós”), em conformidade com a Lei nº 13.709/2018 – Lei Geral de Proteção de Dados (LGPD), bem como com os princípios e diretrizes das normas ISO/IEC 27001, ISO/IEC 27701 e ISO/IEC 29100, que estabelecem boas práticas de segurança da informação, privacidade e proteção de dados pessoais.

O consentimento do titular é uma das bases legais para o tratamento de dados pessoais, conforme o art. 7º, I, da LGPD, devendo ser registrado e mantido como evidência pelo Camarim.

Ao utilizar o sistema, você, como titular dos dados, declara ter lido, compreendido e consentido expressamente com o tratamento de seus dados pessoais, nos termos a seguir:

CLÁUSULA PRIMEIRA – OBJETO DO CONSENTIMENTO E DADOS TRATADOS
O(A) titular AUTORIZA o Camarim a coletar, armazenar e tratar os seguintes dados pessoais, para os fins específicos dispostos na Cláusula Segunda:

| CATEGORIA DO DADO | DADO PESSOAL | FINALIDADE DE TRATAMENTO |
| :--- | :--- | :--- |
| Identificação | Nome completo, CPF, Gênero, Foto de perfil. | Criação e gestão da conta; validação de identidade; personalização do perfil de cliente ou profissional. |
| Contato | E-mail, Telefone, Endereço. | Contato entre cliente e profissional; suporte técnico; envio de notificações; entrega de serviços agendados (Endereço). |
| Acesso e Segurança | Senha, Endereço IP e logs de acesso. | Garantir a segurança, autenticação de acesso e prevenção de fraudes. |
| Financeiro | Dados de pagamento. | Execução de pagamentos pelos serviços contratados e repasse de valores aos profissionais. |
| Conteúdo | Arquivos ou informações enviadas pelo usuário na plataforma (ex: avaliação, histórico de agendamentos). | Disponibilização de arquivos/conteúdos; permitir avaliações e interações. |

Parágrafo Primeiro: O Camarim se reserva o direito de tratar dados pessoais sensíveis (se eventualmente contidos em documentos ou informações enviadas) com segurança reforçada e estritamente para as finalidades essenciais do sistema.

CLÁUSULA SEGUNDA – FINALIDADES DO TRATAMENTO E BASES LEGAIS
Os dados pessoais serão tratados pelas seguintes finalidades, com as respectivas bases legais:

| FINALIDADE DO TRATAMENTO | BASE LEGAL (LGPD) |
| :--- | :--- |
| Criar e gerenciar a conta do usuário e do profissional. | Consentimento (Art. 7º, I) e Execução de Contrato (Art. 7º, V) |
| Permitir a busca, o agendamento de serviços e o contato entre cliente e profissional. | Execução de Contrato (Art. 7º, V) |
| Processar pagamentos e repassar valores aos profissionais. | Execução de Contrato (Art. 7º, V) e Cumprimento de Obrigação Legal/Regulatória (Art. 7º, II) |
| Enviar notificações e comunicações sobre o uso, funcionamento e atualizações da plataforma. | Legítimo Interesse (Art. 7º, IX) e Consentimento (Art. 7º, I) |
| Garantir segurança, autenticação de acesso, prevenção a fraudes e cumprimento das Vedações de Uso (Cláusula Quarta do Termo de Uso). | Legítimo Interesse (Art. 7º, IX) |
| Cumprir obrigações legais e regulatórias. | Cumprimento de Obrigação Legal ou Regulatória (Art. 7º, II) |

CLÁUSULA TERCEIRA – COMPARTILHAMENTO DE DADOS
O Camarim não compartilhará os dados pessoais com terceiros, exceto nas seguintes hipóteses, observando o princípio da necessidade e garantias técnicas e contratuais (ISO/IEC 27001):
1. Com o Profissional ou Cliente: Para viabilizar o agendamento e a prestação do serviço contratado (ex: nome, telefone, e-mail para contato e localização do serviço).
2. Com Prestadores de Serviço Essenciais: Meios de pagamento e serviços técnicos de hosting e suporte (apenas o indispensável para o funcionamento do sistema).
3. Por Autorização do Usuário: Quando houver seu consentimento específico para a finalidade.
4. Por Obrigação Legal: Em cumprimento de ordem judicial ou determinação legal/regulatória.

CLÁUSULA QUARTA – CONTROLADOR E ENCARREGADO (DPO)
Controlador (responsável pelo tratamento): Projeto “CAMARIM”
Canal oficial de contato para privacidade e LGPD (Cláusula Oitava do Termo de Uso): contact.camarim@gmail.com
Encarregado de Proteção de Dados (DPO) – (Cláusula Nona do Termo de Uso):
Nome: Caio Martins Caldeira
Cargo/Função: Desenvolvedor Front-end / Encarregado de Dados (DPO)

CLÁUSULA QUINTA – MEDIDAS DE SEGURANÇA E CONFORMIDADE
O Camarim compromete-se a adotar medidas técnicas e administrativas de segurança, em conformidade com a LGPD e boas práticas baseadas nas normas ISO/IEC 27001, 27701 e 29100, para proteger os dados pessoais, incluindo: criptografia de informações sensíveis, autenticação segura, controle de acesso restrito e Plano de Resposta a Incidentes de Segurança.

CLÁUSULA SEXTA – TEMPO DE ARMAZENAMENTO
Os dados pessoais serão mantidos pelo Camarim pelo período necessário para cumprimento das finalidades descritas, ou conforme exigência legal aplicável (ex: guarda de logs de acesso por 6 meses ou dados financeiros). Após esse período, os dados serão excluídos ou anonimizados, conforme o art. 16 da LGPD.

CLÁUSULA SÉTIMA – DIREITOS DO TITULAR
O titular poderá, a qualquer momento, exercer os direitos previstos na LGPD, incluindo (mas não se limitando a):
1. Confirmar a existência e acessar seus dados.
2. Corrigir dados incompletos, inexatos ou desatualizados.
3. Revogar o consentimento.
4. Solicitar a exclusão da conta e dos dados, quando permitido por lei.
O canal oficial para exercer estes direitos é o e-mail: contact.camarim@gmail.com.

CLÁUSULA OITAVA – CONSENTIMENTO LIVRE, INFORMADO E REVOGAÇÃO
O titular confirma que o consentimento para o tratamento dos dados, conforme as Cláusulas Primeira e Segunda, é dado livremente, após leitura e compreensão integral deste Termo.

Parágrafo Primeiro: O consentimento será coletado via clique em Li e concordo com o Termo de Uso e Consentimento dentro do sistema, sendo este registro mantido como prova do aceite.

Parágrafo Segundo: A revogação do consentimento (exercida através do canal oficial) não afeta a legalidade de qualquer tratamento realizado antes da revogação ou o tratamento baseado em outras bases legais (ex: cumprimento de obrigação legal).

CLÁUSULA NONA – DADOS DE CRIANÇAS E ADOLESCENTES
O tratamento de dados de menores seguirá o art. 14 da LGPD:
1. Crianças (menores de 12 anos): Coleta de dados somente com consentimento específico e em destaque dado pelos pais ou responsáveis legais.
2. Adolescentes (12 a 18 anos): O tratamento visará sempre o melhor interesse, com controles adicionais de segurança e confidencialidade.
3. Medidas Reforçadas: O Camarim se compromete a implementar controles técnicos e operacionais diferenciados (criptografia, controle de acesso) para garantir a privacidade e segurança dos dados dos menores.

CLÁUSULA DÉCIMA – FORO
Fica eleito o foro da comarca de Belo Horizonte/MG para dirimir quaisquer controvérsias oriundas deste Termo.

Belo Horizonte/MG, ____ de __________ de 2025.

USUÁRIO(A):
____________________________________________
Nome completo – CPF

PELO PROJETO “CAMARIM”:
____________________________________________
Caio Martins Caldeira - Encarregado de Dados (DPO)

TESTEMUNHAS:
____________________________________________ - Nome completo / CPF
____________________________________________ - Nome completo / CPF
''',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: concordo,
                  activeColor: const Color(0xFF626BBA),
                  onChanged: (value) {
                    setState(() => concordo = value ?? false);
                  },
                ),
                const Expanded(
                  child: Text(
                    "Li e estou de acordo com os Termos de Uso e Política de Privacidade",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    concordo
                        ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuPage(customerId),
                            ),
                          );
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF626BBA),
                  disabledBackgroundColor: const Color(
                    0xFF626BBA,
                  ).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Prosseguir",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF626BBA),
        unselectedItemColor: const Color(0xFF626BBA).withOpacity(0.5),
        currentIndex: 4,
        onTap: (index) => Navigator.pop(context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Pesquisa"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Horários",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        ],
      ),
    );
  }
}
