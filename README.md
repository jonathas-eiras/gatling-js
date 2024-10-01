# Teste de Carga e Teste de Pico com Gatling e JavaScript

## Sumário
- Visão Geral
- Pré-requisitos
- Instruções para Execução
- Relatório de Execução dos Testes
- Contato

## Visão Geral
Este projeto foi desenvolvido para realizar testes de carga e testes de pico utilizando o Gatling em conjunto com JavaScript. O objetivo é medir a performance de um sistema sob diferentes cenários de carga e identificar potenciais gargalos durante momentos de pico.
Os scripts simulam requisições de compra de passagens no endpoint: [https://www.blazedemo.com/purchase.php]

Os testes de carga simulam usuários acessando o sistema em uma taxa crescente, enquanto os testes de pico simulam um número extremo de usuários em um curto período de tempo.

Os scripts de testes foram desenvolvidos na linguagem JavaScript.
Eles se encontram na pasta /javascript/src.

![image](https://github.com/user-attachments/assets/4a5d476a-ad20-4a5c-aee8-794feb7c4ff8)


## Pré-requisitos
Pré-requisitos instalados antes de executar os testes:

- [Node.js](https://nodejs.org/en) v18 ou posterior (somente versões LTS) e npm v8 ou posterior.


## Instruções para Execução

Abra o terminal e navegue para a pasta `/javascript`

``` bash
cd javascript
```

Execute o comando abaixo para instalar os pacotes e dependências, incluindo o comando gatling.

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
        
* É possível visualizar alguns dados, como:
    * Latência média
    * Percentuais de resposta (50%, 90%, 99%)
    * Número de requisições por segundo
    * Taxa de sucesso/falha de requisições
        

### Análise dos Resultados

Segue uma análise dos resultados obtidos, de acordo com o critério de Aceitação:
 * 250 requisições por segundo com um tempo de resposta 90th percentil inferior a 2 segundos.
   
**Teste de Carga**:
[Gatling Stats - purchase-load.pdf](https://github.com/user-attachments/files/17197386/Gatling.Stats.-.purchase-load.pdf)


  **Requisições simuladas**
  * Foram realizadas um total de 33750 requisições.
  * Passaram 16890 - OK
  * Falharam 16860 - KO
  * Uma porcentagem de falha = 49.97%
 
    ![image](https://github.com/user-attachments/assets/4587aa8e-a1e0-40d8-8042-7935b26ee352)

  **Tempo de resposta**
  * Após a análise do relatório foi percebido que:
    * 26.65% das requisições foram processadas em menos de 800ms (t < 800 ms). Isso indica que essas requisições tiveram um bom desempenho, mas que o sistema não lida tão bem quando se tem muitas solicitações, pois a porcentagem ficou bem abaixo do critério de aceite.
    * 13.21% das requisições foram processadas na faixa de tempo (800 ms ≤ t < 2000 ms), indicando um desempenho moderado, pois além de ser tempos de resposta aceitáveis, podem exigir atenção se for desejada uma otimização adicional.
    * 10.17% das requisições foram processadas na faixa de tempo (t ≥ 2000 ms), mostrando um desempenho lento, pois as solicitações demoraram mais de 1,2 segundos, o que pode indicar gargalos de desempenho ou problemas quando em carga mais alta, podendo afetar negativamente a experiência do usuário.
    * 49.96% das requisições falharam, o que é um problema crítico. O sistema tem uma taxa de falhas alta, onde quase metade das solicitações não foram concluídas com êxito. Isso precisa de atenção imediata para garantir confiabilidade e estabilidade.
   
    ![image](https://github.com/user-attachments/assets/f51bdea9-68ef-42a0-83e3-3dd07e51b7fc)

**Percentil 90 < 2s**
* Foi observado que o critério de aceite não foi nada satisfatório, pois as requisições não mantiveram um tempo de resposta 90th percentil inferior a 2 segundos. Notasse que dentro do percentil de 90, o número de requisições abaixo dos 2 segundos foram muito inferior em relação ao total de requisições.

![image](https://github.com/user-attachments/assets/23a89616-085b-437c-88b4-9cc0ccff2052)

**Teste de Pico**:
[Gatling Stats - purchase-spike.pdf](https://github.com/user-attachments/files/17197495/Gatling.Stats.-.purchase-spike.pdf)

  **Requisições simuladas**
  * Foram realizadas um total de 15250 requisições.
  * Passaram 12991 - OK
  * Falharam 2259 - KO
  * Uma porcentagem de falha = 14.81%
 
    ![image](https://github.com/user-attachments/assets/24e32856-7e2b-4886-9d49-c8a0a7fe104a)


  **Tempo de resposta**
  * Após a análise do relatório foi percebido que:
    * 40.89% das requisições foram processadas em menos de 800ms (t < 800 ms). Isso indica que essas requisições tiveram um bom desempenho, mas que o sistema não suporta picos de requisições, pois a porcentagem não chegou nem a metade, o que fica bem distante do critério de aceite.
    * 23.19% das requisições foram processadas na faixa de tempo (800 ms ≤ t < 2000 ms), indicando um desempenho moderado, pois além de ser tempos de resposta aceitáveis, podem exigir atenção se for desejada uma otimização adicional.
    * 21.11% das requisições foram processadas na faixa de tempo (t ≥ 2000 ms), mostrando um desempenho lento, pois as solicitações demoraram mais de 1,2 segundos, o que pode indicar gargalos de desempenho ou problemas quando em picos de requisições, podendo afetar negativamente a experiência do usuário.
    * 14.81% das requisições falharam, o que é um problema. O sistema tem uma taxa de falhas abaixo dos sucessos, mas ainda assim não deixa de ser uma taxa alta, pois um grande número de solicitações não foram concluídas com êxito. Isso precisa de atenção imediata para garantir confiabilidade e estabilidade.
   
   ![image](https://github.com/user-attachments/assets/36e4b8c0-2464-4822-b6b9-4c6b50500541)


**Percentil 90 < 2s**
* Foi observado que o critério de aceite, assim como no teste de carga, também não foi nada satisfatório, pois as requisições não mantiveram um tempo de resposta 90th percentil inferior a 2 segundos. Notasse também que dentro do percentil de 90, o número de requisições abaixo dos 2 segundos foram poucas em relação ao total de requisições.
![image](https://github.com/user-attachments/assets/a89905be-77d8-474e-8c7f-241553ce638a)


Contato
-------

Para dúvidas ou sugestões, entre em contato:

**E-mail**: jhon4eiras@gmail.com
    

