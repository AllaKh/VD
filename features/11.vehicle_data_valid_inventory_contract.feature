@VD @Contract
Feature: Vehicle Driven Inventory - Verify Inventory validity - Contract test

  Background:
    Given all MS return valid responses

  @TC151458_01
  Scenario: Inventory Validity - validInventory is missing

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC000005_1 |
    When vehicle sends "missing_valid_inventory.json" inventory update via "MQTT":
      | vin            | requestSource | useSignature |
      | VIN_TC000005_1 | VEHICLE       | true         |
    * wait 1 sec for inventory to be merged
    Then Vehicle inventory for "VIN_TC000005_1" was not updated
    And log contains the following error: "valid inventory field is empty or missing"
    And log contains the following error: "inventory is not valid"

  @TC151458_02
  Scenario: Inventory Validity - validInventory is empty

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC000005_1 |
    When vehicle sends "emptyValidInventory.json" inventory update via "MQTT":
      | vin            | requestSource | useSignature |
      | VIN_TC000005_1 | VEHICLE       | true         |
    * wait 1 sec for inventory to be merged
    Then Vehicle inventory for "VIN_TC000005_1" was not updated
    And log contains the following error: "valid inventory field is empty or missing"
    And log contains the following error: "inventory is not valid"

  @TC151458_03
  Scenario: Inventory Validity - validInventory with invalid value

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC000007_1 |
    When vehicle sends "wrong_value_valid_inventory.json" inventory update via "MQTT":
      | vin            | requestSource | useSignature |
      | VIN_TC000007_1 | VEHICLE       | true         |
    * wait 1 sec for inventory to be merged
    Then Vehicle inventory for "VIN_TC000007_1" was not updated
    And log contains the following error: "VDI message parsing failed"

  @TC151458_04
  Scenario: Inventory Validity - collection status is missing

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC000006_1 |
    When vehicle sends "missing_collection_status.json" inventory update via "MQTT":
      | vin            | requestSource | useSignature |
      | VIN_TC000006_1 | VEHICLE       | true         |
    * wait 1 sec for inventory to be merged
    Then Vehicle inventory for "VIN_TC000006_1" was not updated
    And log contains the following error: "valid inventory field is empty or missing"
    And log contains the following error: "inventory is not valid"