import {
  StringBody,
  constantUsersPerSec,
  exec,
  global,
  scenario,
  simulation,
  rampUsersPerSec
} from "@gatling.io/core";
import { http, status } from "@gatling.io/http";
import { faker } from "@faker-js/faker";

let user = {
  name: faker.person.firstName() + " " + faker.person.lastName(),
  address: faker.location.streetAddress(),
  city: faker.location.city(),
  state: faker.location.state(),
  zipcode: faker.location.zipCode(),
  cardNumber: faker.finance.creditCardNumber(),
  month: faker.number.int({ min: 1, max: 12 }),
  year: faker.number.int({ min: 2021, max: 2024 }),
  cardName: faker.finance.accountName()
};

export default simulation((setUp) => {
  const httpProtocol = http
    .baseUrl("https://www.blazedemo.com")
    .acceptHeader("application/json")
    .contentTypeHeader("application/json");

  const purchaseTicket = exec(
    http("purchase-load")
      .post("/purchase.php")
      .body(StringBody(JSON.stringify(user)))
      .asJson()
      .check(status().is(200)),
  );

  const myScenario = scenario("Purchase Ticket Success").exec(purchaseTicket);

  const loadTest = setUp(myScenario.injectOpen(
    rampUsersPerSec(0).to(250).during(15),
    constantUsersPerSec(250).during(120),
    rampUsersPerSec(250).to(0).during(15)))
    .protocols(httpProtocol);

  loadTest.assertions(
    global().responseTime().percentile(90).lt(2000),
    global().failedRequests().percent().lt(1)
  );
});
