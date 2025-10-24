import 'package:camarim_backend/pages/menu_page.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
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
            // Título Principal da Página
            const Text(
              "Termos de Uso e Consentimento",
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
                  border: Border.all(color: const Color(0xFF626BBA)),
                ),
                child: SingleChildScrollView(
                  child: _buildFullTermsContent(), // Chamada para o conteúdo formatado
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
                    "Li e estou de acordo com os Termos de Uso e Consentimento para Privacidade",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: concordo
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuPage(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF626BBA),
                  disabledBackgroundColor:
                      const Color(0xFF626BBA).withOpacity(0.3),
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

  // Função para criar um título principal
  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 19,
          color: Color(0xFF626BBA),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // Função para criar um subtítulo/cláusula
  Widget _buildSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Função para criar um parágrafo
  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          fontSize: 15,
          height: 1.4,
          color: Colors.black87,
        ),
      ),
    );
  }

  // CONTEÚDO UNIFICADO E FORMATADO
  Widget _buildFullTermsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =========================================================
        //                 INÍCIO: TERMO DE USO
        // =========================================================
        _buildTitle('1. TERMO DE USO DO SISTEMA “CAMARIM”'),
        _buildParagraph(
          'Este Termo de Uso (“Termo”) é um acordo legal entre você, o(a) usuário(a) do sistema, e os desenvolvedores do projeto “Camarim” (doravante denominado “Camarim” ou “Nós”), um sistema desenvolvido para buscar profissionais da área de estética, encontrar e agendar serviços, permitir avaliações e conectar profissionais cadastrados a clientes, mediante cobrança de taxa pelos serviços contratados dentro da plataforma.',
        ),
        _buildParagraph(
          'Ao acessar ou utilizar o Camarim, você declara ter lido, compreendido e aceitado integralmente este Termo de Uso, bem como nossa Política de Privacidade e a Lei Geral de Proteção de Dados Pessoais (LGPD – Lei nº 13.709/2018). Caso você não concorde com estes termos, não deverá utilizar o sistema.',
        ),
        
        _buildSubtitle('CLÁUSULA PRIMEIRA – DAS CONDIÇÕES GERAIS DE USO'),
        _buildParagraph(
          'O Camarim é destinado a conectar clientes a profissionais da área de estética, permitindo busca de serviços, agendamento, avaliação, interação, troca de informações e contratação dos profissionais cadastrados, mediante regras e taxas previstas pelo sistema.',
        ),
        
        _buildSubtitle('CLÁUSULA SEGUNDA – DA COLETA E USO DE DADOS PESSOAIS'),
        _buildParagraph(
          'O usuário declara estar ciente de que o Camarim coleta e armazena os seguintes dados pessoais, quando informados: Nome completo, E-mail, Telefone, Senha, CPF, Endereço, Gênero, Dados de pagamento, Endereço IP e logs de acesso, Foto de perfil (se enviada) e Arquivos ou informações enviadas pelo usuário na plataforma.',
        ),
        
        _buildSubtitle('CLÁUSULA TERCEIRA – FINALIDADE DA COLETA'),
        _buildParagraph(
          'A coleta e o tratamento dos dados pessoais têm as seguintes finalidades essenciais: Criar e gerenciar a conta do usuário, Permitir contato entre cliente e profissional, Viabilizar agendamentos, Garantir segurança e autenticação de acesso, Executar pagamentos e repassar valores aos profissionais, Enviar notificações e comunicações sobre o uso da plataforma, Disponibilizar arquivos ou conteúdos enviados pelo usuário, e Cumprir obrigações legais e regulatórias.',
        ),
        
        _buildSubtitle('CLÁUSULA QUARTA – VEDAÇÕES DE USO'),
        _buildParagraph(
          'O usuário se compromete a não utilizar o Camarim para qualquer finalidade ilícita, antiética ou que viole este Termo, incluindo, mas não se limitando a: Publicar conteúdo ilegal, ofensivo, difamatório, obsceno ou prejudicial; Tentar invadir, alterar ou danificar contas de outros usuários; Fraudar pagamentos, avaliações ou identidade; Violar direitos autorais, de imagem ou outros direitos de terceiros.',
        ),
        
        _buildSubtitle('CLÁUSULA QUINTA – ACEITAÇÃO IMPLÍCITA'),
        _buildParagraph(
          'A utilização do Camarim implica na aceitação plena e irrestrita deste Termo de Uso.',
        ),
        
        _buildSubtitle('CLÁUSULA SEXTA – DA PROTEÇÃO DOS DADOS'),
        _buildParagraph(
          'O Camarim compromete-se a adotar medidas técnicas e administrativas de segurança, em conformidade com a LGPD e boas práticas baseadas nas normas ISO/IEC 27001, 27701 e 29100, incluindo: Criptografia de informações sensíveis, Autenticação segura e controle de acesso, Banco de dados com restrição de permissões e Plano de resposta a incidentes de segurança.',
        ),

        // CLÁUSULA SÉTIMA A DÉCIMA QUARTA (Direitos e Disposições Finais do Termo de Uso)
        _buildSubtitle('CLÁUSULA SÉTIMA – DO COMPARTILHAMENTO DE DADOS'),
        _buildParagraph('Os dados pessoais não serão compartilhados com terceiros, exceto: Quando houver autorização do usuário; Em cumprimento de ordem judicial ou obrigação legal; Para serviços técnicos indispensáveis ao funcionamento do sistema (ex.: meios de pagamento).'),
        
        _buildSubtitle('CLÁUSULA OITAVA – DOS DIREITOS DO TITULAR DOS DADOS'),
        _buildParagraph('Nos termos da LGPD, o usuário poderá, a qualquer momento: Solicitar informações sobre o uso de seus dados; Corrigir informações incompletas ou desatualizadas; Revogar consentimento; Solicitar exclusão da conta e dos dados, quando permitido por lei. Canal oficial: contact.camarim@gmail.com'),
        
        _buildSubtitle('CLÁUSULA NONA – DO RESPONSÁVEL PELO TRATAMENTO DOS DADOS (DPO)'),
        _buildParagraph('O responsável pelo tratamento dos dados pessoais no Camarim é: Caio Martins Caldeira – Desenvolvedor Front-end / Encarregado de Dados (DPO)'),
        
        _buildSubtitle('CLÁUSULA DÉCIMA – DA EXATIDÃO DOS DADOS'),
        _buildParagraph('O usuário é o único responsável pela veracidade, atualização e exatidão das informações fornecidas. O Camarim não se responsabiliza por dados falsos, desatualizados, incorretos ou incompletos inseridos pelo usuário.'),
        
        _buildSubtitle('CLÁUSULA DÉCIMA PRIMEIRA – DA TRANSPARÊNCIA'),
        _buildParagraph('O Camarim garante transparência no tratamento de dados pessoais. As solicitações dos usuários serão respondidas em até 48 horas para confirmações simples e em até 15 dias para demandas complexas.'),
        
        _buildSubtitle('CLÁUSULA DÉCIMA SEGUNDA – DADOS DE CRIANÇAS E ADOLESCENTES'),
        _buildParagraph('O tratamento de dados de menores seguirá o art. 14 da LGPD, incluindo: Coleta de dados de crianças apenas com consentimento dos responsáveis; Tratamento de dados de adolescentes visando sempre o melhor interesse; Controles adicionais de segurança e confidencialidade.'),
        
        _buildSubtitle('CLÁUSULA DÉCIMA TERCEIRA – ATUALIZAÇÕES DO TERMO'),
        _buildParagraph('Este Termo poderá ser atualizado periodicamente em razão de mudanças legais, técnicas ou operacionais, passando a valer a partir da nova data de publicação.'),
        
        _buildSubtitle('CLÁUSULA DÉCIMA QUARTA – DO FORO'),
        _buildParagraph('Fica eleito o foro da comarca de Belo Horizonte/MG para dirimir quaisquer controvérsias.'),
        
        // =========================================================
        //            FIM: TERMO DE USO
        // =========================================================
        
        
        // =========================================================
        //        INÍCIO: TERMO DE CONSENTIMENTO (PRIVACIDADE)
        // =========================================================
        _buildTitle('2. TERMO DE CONSENTIMENTO PARA TRATAMENTO DE DADOS PESSOAIS'),
        
        _buildParagraph(
          'Este Termo formaliza sua autorização expressa, livre, informada e inequívoca para o tratamento de seus dados pessoais pelo Projeto “CAMARIM”, em conformidade com a LGPD e as normas ISO/IEC 27001, 27701 e 29100. O consentimento do titular é uma das bases legais para o tratamento de dados pessoais (Art. 7º, I, da LGPD).',
        ),
        _buildParagraph(
          'Ao clicar em "Prosseguir", você declara ter lido, compreendido e consentido expressamente com o tratamento de seus dados pessoais, nos termos a seguir:',
        ),

        _buildSubtitle('CLÁUSULA PRIMEIRA – DADOS TRATADOS E FINALIDADES'),
        _buildParagraph(
          'Você AUTORIZA o Camarim a coletar, armazenar e tratar os dados de Identificação (Nome, CPF, Gênero), Contato (E-mail, Telefone, Endereço), Acesso/Segurança (Senha, IP) e Financeiro, estritamente para as finalidades de: Criação/Gestão da conta, Agendamento de serviços, Processamento de pagamentos e Suporte técnico.',
        ),

        _buildSubtitle('CLÁUSULA SEGUNDA – COMPARTILHAMENTO DE DADOS'),
        _buildParagraph(
          'O compartilhamento de dados se dará apenas para viabilizar a prestação do serviço contratado (com o Profissional ou Cliente), com Prestadores de Serviço Essenciais (meios de pagamento, hosting) ou por Obrigação Legal.',
        ),
        
        _buildSubtitle('CLÁUSULA TERCEIRA – CONTROLADOR E ENCARREGADO (DPO)'),
        _buildParagraph(
          'Controlador: Projeto “CAMARIM”. Encarregado de Dados (DPO): Caio Martins Caldeira. Canal oficial: contact.camarim@gmail.com.',
        ),
        
        _buildSubtitle('CLÁUSULA QUARTA – MEDIDAS DE SEGURANÇA E ARMAZENAMENTO'),
        _buildParagraph(
          'O Camarim adota medidas técnicas (criptografia, autenticação segura) conforme LGPD e ISOs, e manterá os dados pelo período necessário para o cumprimento das finalidades ou exigência legal.',
        ),
        
        _buildSubtitle('CLÁUSULA QUINTA – DIREITOS E REVOGAÇÃO'),
        _buildParagraph(
          'O titular pode exercer seus direitos (Acesso, Correção, Exclusão, Revogação do Consentimento) a qualquer momento através do canal oficial. A revogação não afeta tratamentos realizados antes da revogação ou o tratamento baseado em outras bases legais.',
        ),

        _buildSubtitle('CLÁUSULA SEXTA – DADOS DE CRIANÇAS E ADOLESCENTES'),
        _buildParagraph(
          'O tratamento de dados de menores seguirá o art. 14 da LGPD, exigindo consentimento específico dos pais/responsáveis para crianças e buscando sempre o melhor interesse dos adolescentes, com controles reforçados.',
        ),

        _buildParagraph('Belo Horizonte/MG, ____ de __________ de 2025.'),
        
        const SizedBox(height: 100), // Espaço extra para visualização no final
      ],
    );
  }
}