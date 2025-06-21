@VD
Feature: Vehicle Driven Inventory - Verify Inventory validity

  Background:
    Given all MS return valid responses

  @TC151459
  Scenario: Inventory Validity - Invalid inventory with use signature true

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC000004_1 |
    And vehicle sends "invalid_inventory.json" inventory update via "MQTT":
      | vin            | requestSource | useSignature |
      | VIN_TC000004_1 | VEHICLE       | true         |
    * wait 1 sec for inventory to be merged
    Then Vehicle inventory for "VIN_TC000004_1" was not updated
    And log contains the following error: "inventory is not valid"

  @TC151460
  Scenario: Inventory Validity - Invalid inventory with use signature false

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC000003_1 |
    When set use signature configuration to false
    And vehicle sends "invalid_inventory.json" inventory update via "MQTT":
      | vin            | requestSource | useSignature |
      | VIN_TC000003_1 | VEHICLE       | false        |
    * wait 1 sec for inventory to be merged
    Then Vehicle inventory for "VIN_TC000003_1" was not updated
    And log contains the following error: "inventory is not valid"