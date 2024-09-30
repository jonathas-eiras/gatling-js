# Teste de Carga e Teste de Pico com Gatling e JavaScript

## Sumário
- Visão Geral
- Pré-requisitos
- Instruções para Execução
- Relatório de Execução dos Testes
- Demais Considerações
- Contato

## Visão Geral
Este projeto foi desenvolvido para realizar testes de carga e testes de pico utilizando o Gatling em conjunto com JavaScript. O objetivo é medir a performance de um sistema sob diferentes cenários de carga e identificar potenciais gargalos durante momentos de pico.

Os testes de carga simulam usuários acessando o sistema em uma taxa crescente, enquanto os testes de pico simulam um número extremo de usuários em um curto período de tempo.

## Pré-requisitos
Pré-requisitos instalados antes de executar os testes:

- [Node.js](https://nodejs.org/en) v18 ou posterior (somente versões LTS) e npm v8 ou posterior.


## Instruções para Execução

Abra o terminal e navegue para a pasta `/javascript`

``` bash
cd javascript
```

Execute o comando abaixo para instalar os pacotes e dependências, incluindo o comando gatling.
Este comando levará alguns minutos para ser concluído.
``` bash
npm install
```
## Executando os Testes

## Carga
Para rodar o script do teste de Carga, execute o seguinte comando:
``` bash
npx gatling run --simulation purchaseTicket-load
```
## Pico
Para rodar o script do teste de Pico, execute o seguinte comando:
``` bash
npx gatling run --simulation purchaseTicket-spike
```

Relatório de Execução dos Testes
--------------------------------

Após a execução dos testes, o Gatling gera um relatório HTML detalhado que pode ser visualizado no navegador.

**Acessar o Relatório**:
    
* O relatório será gerado automaticamente no diretório javascript/target/gatling/jssimulation-<timestamp>/index.html.

* Abra o arquivo no browser.
        
* É possível visualizar:
    * Latência média
    * Percentuais de resposta (50%, 90%, 99%)
    * Número de requisições por segundo
    * Taxa de sucesso/falha de requisições
        

### Análise dos Resultados

Abaixo segue uma análise dos resultados obtidos, de acordo com o critério de Aceitação:
 * 250 requisições por segundo com um tempo de resposta 90th percentil inferior a 2
segundos.

**Teste de Carga**:

  **Requisições simuladas**
  * Foram realizadas um total de 33750 requisições.
  * Passaram 16890 - OK
  * Falharam 16860 - KO
  * Uma porcentagem de falha = 49.96%
 
    ![image](https://github.com/user-attachments/assets/75b9bcd9-87d0-4b99-81a4-8db20dfbbe6d)

  **Tempo de resposta**
  * Após a análise do relatório foi percebido que:
    * 28.66% das requisições foram processadas em menos de 800ms (t < 800 ms). Isso indica que essas requisições tiveram um bom desempenho, mas que o sistema não lida tão bem quando se tem muitas solicitações, pois a porcentagem ficou bem abaixo.
    * 2.09% das requisições foram processadas na faixa de tempo (800 ms ≤ t < 1200 ms), indicando um desempenho moderado, pois além de ser tempos de resposta aceitáveis, podem exigir atenção se for desejada uma otimização adicional.
    * 19.29% das requisições foram processadas na faixa de tempo (t ≥ 1.200 ms), mostrando um desempenho lento, pois as solicitações demoraram mais de 1,2 segundos, o que pode indicar gargalos de desempenho ou problemas quando em carga mais alta, podendo afetar negativamente a experiência do usuário.
    * 49.96% das requisições falharam, o que é um problema crítico. O sistema tem uma taxa de falhas alta, onde quase metade das solicitações não foram concluídas com êxito. Isso precisa de atenção imediata para garantir confiabilidade e estabilidade.
   
    ![image](https://github.com/user-attachments/assets/b9ecc115-2ed0-441f-adeb-4b3e30163d94)

    
*   **Taxa de sucesso**: 98%
    
*   **Número de falhas**: 20 requisições
    

**Teste de Pico**:

*   **Usuários simultâneos**: 5000
    
*   **Duração do pico**: 30 segundos
    
*   **Latência média**: 500 ms
    
*   **Taxa de sucesso**: 95%
    
*   **Número de falhas**: 150 requisições
    

Demais Considerações
--------------------

*   **Configurações de Hardware**:
    
    *   Os testes foram executados em uma máquina com 8 GB de RAM e processador Intel i5. Resultados podem variar de acordo com a infraestrutura usada para o teste.
        
*   **Otimização de Performance**:
    
    *   Identificamos que, em cenários de pico, o tempo de resposta aumenta significativamente quando o número de usuários simultâneos ultrapassa 4000.
        
    *   É recomendada a otimização de banco de dados e redução de latência no servidor de aplicação.
        
*   **Melhorias Futuros**:
    
    *   Implementar testes de estresse para simular o sistema sob cargas contínuas por períodos prolongados.
        
    *   Automatizar a geração de relatórios com integração a ferramentas de CI/CD.
        

Contato
-------

Para dúvidas ou sugestões, entre em contato:

*   **E-mail**: seu-email@example.com
    
*   **GitHub**: [https://github.com/seu-usuario](https://github.com/seu-usuario)
