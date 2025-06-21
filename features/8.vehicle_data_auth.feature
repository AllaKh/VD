@VD @Auth
Feature: Vehicle Data Authentication & Authorisation

  @TC147419
  Scenario: VD token validation - Verify user permissions - GET /v1/vehicles/{id}
    Given following vehicles exist on swm db:
      | vin      | creationTime | status | domainIds | vehicleModelId |
      | VIN_TC05 | 1698682310   | Active | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin      |
      | VIN_TC05 |
    When user with "create" permission is logged
    Then response code for GET vehicles by id VIN_TC05 is HTTP 401
    When user with "delete" permission is logged
    Then response code for GET vehicles by id VIN_TC05 is HTTP 401
    When user with "read" permission is logged
    Then response code for GET vehicles by id VIN_TC05 is HTTP 200

  @TC147420
  Scenario: VD token validation - Verify user permissions - POST /v1/vehicles/filter
    When user with "create" permission is logged
    Then response code for POST vehicles filter is HTTP 401
    When user with "delete" permission is logged
    Then response code for POST vehicles filter is HTTP 401
    When user with "read" permission is logged
    Then response code for POST vehicles filter is HTTP 200

  @TC147421
  Scenario: VD token validation - Verify user permissions - POST /v1/vehicles/count
    When user with "create" permission is logged
    Then response code for POST vehicles count is HTTP 401
    When user with "delete" permission is logged
    Then response code for POST vehicles count is HTTP 401
    When user with "read" permission is logged
    Then response code for POST vehicles count is HTTP 200

  @TC147422
  Scenario: VD token validation - Verify user permissions - POST /v1/vehicles/inventory/filter
    When user with "create" permission is logged
    Then response code for POST vehicles inventory filter is HTTP 401
    When user with "delete" permission is logged
    Then response code for POST vehicles inventory filter is HTTP 401
    When user with "read" permission is logged
    Then response code for POST vehicles inventory filter is HTTP 200

  @TC147423
  Scenario: VD token validation - Verify user permissions - POST /v1/vehicles/software/filter
    When user with "create" permission is logged
    Then response code for POST vehicles software filter is HTTP 401
    When user with "delete" permission is logged
    Then response code for POST vehicles software filter is HTTP 401
    When user with "read" permission is logged
    Then response code for POST vehicles software filter is HTTP 200

  @TC147424
  Scenario: VD token validation - Verify user permissions - POST /v1/vehicles/terminalAccountAggregation
    When user with "create" permission is logged
    Then response code for POST vehicles terminal account aggregation is HTTP 401
    When user with "delete" permission is logged
    Then response code for POST vehicles terminal account aggregation is HTTP 401
    When user with "read" permission is logged
    Then response code for POST vehicles terminal account aggregation is HTTP 200

  @TC147425
  Scenario: VD token validation - Verify user permissions - GET /v1/vehicleData/{id}
    Given following vehicles exist on swm db:
      | vin      | creationTime | status | domainIds | vehicleModelId |
      | VIN_TC11 | 1698682310   | Active | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin      |
      | VIN_TC11 |
    When user with "create" permission is logged
    Then response code for GET vehicleData id is HTTP 401
    When user with "delete" permission is logged
    Then response code for GET vehicleData id is HTTP 401
    When user with "read" permission is logged
    Then response code for GET vehicleData id is HTTP 200

  @TC147426
  Scenario: VD token validation - Verify user permissions - GET /v1/vehicleData/vin/{vin}
    Given following vehicles exist on swm db:
      | vin      | creationTime | status | domainIds | vehicleModelId |
      | VIN_TC12 | 1698682310   | Active | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin      |
      | VIN_TC12 |
    When user with "create" permission is logged
    Then response code for GET vehicleData by VIN_TC12 is HTTP 401
    When user with "delete" permission is logged
    Then response code for GET vehicleData by VIN_TC12 is HTTP 401
    When user with "read" permission is logged
    Then response code for GET vehicleData by VIN_TC12 is HTTP 200

  @TC147427
  Scenario: VD token validation - Verify user permissions - DELETE /v1/vehicleData/vinList
    Given following vehicles exist on swm db:
      | vin      | creationTime | status | domainIds | vehicleModelId |
      | VIN_TC13 | 1698682310   | Active | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin      |
      | VIN_TC13 |
    When user with "create" permission is logged
    Then response code for DELETE vehicleData is HTTP 401 for the following vehicles:
      | VIN_TC13 |
    When user with "read" permission is logged
    Then response code for DELETE vehicleData is HTTP 401 for the following vehicles:
      | VIN_TC13 |
    When user with "delete" permission is logged
    Then response code for DELETE vehicleData is HTTP 200 for the following vehicles:
      | VIN_TC13 |

  @TC147428
  Scenario: VD token validation - Verify user permissions - PATCH /v1/vehicleData
    Given following vehicles exist on swm db:
      | vin      | creationTime | status | domainIds | vehicleModelId |
      | VIN_TC14 | 1698682310   | Active | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin      |
      | VIN_TC14 |
    When user with "delete" permission is logged
    Then response code for PATCH vehicleData is HTTP 401, with inventory file "updateVehicleDataWithoutSW.json" and following parameters:
      | vin      | timestamp | sequence | inventoryType |
      | VIN_TC14 | 1234567   | 2        | SW_FULL       |
    When user with "read" permission is logged
    Then response code for PATCH vehicleData is HTTP 401, with inventory file "updateVehicleDataWithoutSW.json" and following parameters:
      | vin      | timestamp | sequence | inventoryType |
      | VIN_TC14 | 1234567   | 2        | SW_FULL       |
    When user with "create" permission is logged
    Then response code for PATCH vehicleData is HTTP 200, with inventory file "updateVehicleDataWithoutSW.json" and following parameters:
      | vin      | timestamp | sequence | inventoryType |
      | VIN_TC14 | 1234567   | 2        | SW_FULL       |

  @TC147429
  Scenario: VD token validation - Verify user permissions - POST /v1/vehicleData/ecuData
    When user with "create" permission is logged
    Then response code for POST vehicleData ecu data is HTTP 401
    When user with "delete" permission is logged
    Then response code for POST vehicleData ecu data is HTTP 401
    When user with "read" permission is logged
    Then response code for POST vehicleData ecu data is HTTP 200

  @TC147430 @Negative
  Scenario: VD token validation - Token expired (exp)
    Given following vehicles exist on swm db:
      | vin       | creationTime | status | domainIds | vehicleModelId |
      | VIN_TC224 | 1698682310   | Active | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin       |
      | VIN_TC224 |
    When user tries to login with expired token
    Then response code for POST vehicles filter is HTTP 401

  @TC147431 @Negative
  Scenario: VD token validation - Token with create time in the future (nbf)
    Given following vehicles exist on swm db:
      | vin       | creationTime | status | domainIds | vehicleModelId |
      | VIN_TC225 | 1698682310   | Active | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin       |
      | VIN_TC225 |
    When user tries to login with token valid in the future
    Then response code for POST vehicles filter is HTTP 401

  @TC147432 @Negative
  Scenario: VD token validation - Token with no signature
    Given following vehicles exist on swm db:
      | vin       | creationTime | status | domainIds | vehicleModelId |
      | VIN_TC326 | 1698682310   | Active | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin       |
      | VIN_TC326 |
    When there is token with no signature
    Then response code for POST vehicles filter is HTTP 401