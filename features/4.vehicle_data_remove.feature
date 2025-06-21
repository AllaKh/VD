@VD
Feature: Vehicle Data Remove

  @TC135624
  Scenario: Update inventory with new and remove old HWs/SWs

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC135624_1 |
    And vehicle sends create inventory via API:
      | vin            |
      | VIN_TC135624_1 |
    When vehicle sends "remove_ecu_from_inventory.json" inventory update via "MQTT":
      | vin            | requestSource |
      | VIN_TC135624_1 | VEHICLE       |
    And wait 1 sec for inventory to be merged
    And vehicle sends "add_sw_to_inventory.json" inventory update via "MQTT":
      | vin            | requestSource |
      | VIN_TC135624_1 | VEHICLE       |
    And wait 1 sec for inventory to be merged
    Then inventory with following ECUs and software exist for "VIN_TC135624_1":
      | nodeAddress | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | COMPA1  | 1       | [blank]       | 0001-1111  | 1111         | false          |
      | MOST1111    | COMPA2  | 2       |               |            |              |                |
      | MOST4444    | COMPD1  | 1       |               | 0001-4444  | 4444         | false          |
      | MOST4444    | COMPD2  | 2       |               |            |              |                |
      | MOST4444    | COMPD3  | 3       |               |            |              |                |
      | MOST3333    | COMPC1  | 1       |               | 0001-3333  | 3333         | false          |
      | MOST3333    | COMPC4  | 4       |               |            |              |                |
      | MOST3333    | COMPC6  | 6       |               |            |              |                |