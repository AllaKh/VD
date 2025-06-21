@VD
Feature: Vehicle Data Update

  @TC135325
  Scenario: sunny day updates (SW_FULL, SW_PARTIAL, HW_FULL, HW_PARTIAL) with  higher sequence and different complianceIds
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC135325_1 |
      | VIN_TC135325_2 |
      | VIN_TC135325_3 |
      | VIN_TC135325_4 |
    And vehicle sends create inventory via API:
      | vin            |
      | VIN_TC135325_1 |
      | VIN_TC135325_2 |
      | VIN_TC135325_3 |
      | VIN_TC135325_4 |
    When vehicle sends updated inventory via API:
      | vin            | sequence | inventoryType |
      | VIN_TC135325_1 | 3        | SW_FULL       |
      | VIN_TC135325_2 | 3        | SW_PARTIAL    |
      | VIN_TC135325_3 | 3        | HW_FULL       |
      | VIN_TC135325_4 | 3        | HW_PARTIAL    |
    Then inventory with following ECU and software exists for "VIN_TC135325_1":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1.0     | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA3  | 3.0     |               |            |              |                |
      | MOST1111    |                | COMPA4  | 4.0     |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1.0     |               | 0001-3333  | 3333         | true           |
      | MOST3333    |                | COMPC2  | 2.0     |               |            |              |                |
      | MOST3333    |                | COMPC3  | 3.0     |               |            |              |                |
      | MOST4444    |                | COMPD1  | 1.0     |               | 0001-4444  | 4444         | false          |
      | MOST4444    |                | COMPD2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE1  | 1.0     |               | 0001-5555  | 5555         | false          |
      | MOST5555    |                | COMPE2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE3  | 3.0     |               |            |              |                |
    * inventory with following ECU and software exists for "VIN_TC135325_2":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | true           | COMPA1  | 1.0     | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |            |              |                |
      | MOST1111    |                | COMPA3  | 3.0     |               |            |              |                |
      | MOST1111    |                | COMPA4  | 4.0     |               |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1.0     |               | 0001-3333  | 3333         | true           |
      | MOST3333    |                | COMPC2  | 2.0     |               |            |              |                |
      | MOST3333    |                | COMPC3  | 3.0     |               |            |              |                |
      | MOST4444    |                | COMPD1  | 1.0     |               | 0001-4444  | 4444         | false          |
      | MOST4444    |                | COMPD2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE1  | 1.0     |               | 0001-5555  | 5555         | false          |
      | MOST5555    |                | COMPE2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE3  | 3.0     |               |            |              |                |
    * inventory with following ECU and software exists for "VIN_TC135325_3":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | true           | COMPA1  | 1       | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               | 0001-3333  | 3333         | true           |
      | MOST3333    |                | COMPC2  | 2       |               |            |              |                |
      | MOST4444    |                | COMPD1  | 1.0     |               | 0001-4444  | 4444         | false          |
      | MOST4444    |                | COMPD2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE1  | 1.0     |               | 0001-5555  | 5555         | false          |
      | MOST5555    |                | COMPE2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE3  | 3.0     |               |            |              |                |
    * inventory with following ECU and software exists for "VIN_TC135325_4":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | true           | COMPA1  | 1       | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               | 0001-3333  | 3333         | true           |
      | MOST3333    |                | COMPC2  | 2       |               |            |              |                |
      | MOST4444    |                | COMPD1  | 1.0     |               | 0001-4444  | 4444         | false          |
      | MOST4444    |                | COMPD2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE1  | 1.0     |               | 0001-5555  | 5555         | false          |
      | MOST5555    |                | COMPE2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE3  | 3.0     |               |            |              |                |

  @TC137847-1 @Negative
  Scenario Outline: rainy day updates inventory via API with <vin> validations <errorMessage>
    When vehicle sends incorrect inventory via API:
      | vin   |
      | <vin> |
    Then proper response is returned:
      | Status | Code             | Message        |
      | 400    | vd.invalid.input | <errorMessage> |

    Examples:
      | vin        | errorMessage                                                                                                                                                                                                                                                                                     |
      | [blank]    | vin must be 256 characters or less, not empty                                                                                                                                                                                                                                                    |
      | ''         | JSON object is not valid. Reasons (1): vin contains invalid characters                                                                                                                                                                                                                           |
      | !@#$%^&*(+ | JSON object is not valid. Reasons (1): vin contains invalid characters                                                                                                                                                                                                                           |
      | 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678905555567 | must be 256 characters or less, not empty |

  @TC137847-2 @Negative
  Scenario Outline: rainy day updates inventory via API with <timestamp> validations <errorMessage>
    Given following vehicles exist on swm db:
      | vin            |
      | Vin_TC137847_1 |
    When vehicle sends incorrect inventory via API:
      | vin            | timestamp   |
      | Vin_TC137847_1 | <timestamp> |
    Then proper response is returned:
      | Status | Code             | Message        |
      | 400    | vd.invalid.input | <errorMessage> |

    Examples:
      | timestamp | errorMessage                                                                        |
      | abc       | Cannot deserialize value of type `long` from String "abc": not a valid `long` value |
      | [blank]   | JSON object is not valid. Reasons (1): Input timestamp cannot be negative           |
      | ''        | Cannot deserialize value of type `long` from String "''": not a valid `long` value  |
      | -123      | Input timestamp cannot be negative                                                  |

  @TC137847-3 @Negative
  Scenario Outline: rainy day updates inventory via API with <sequence> validations <errorMessage>
    Given following vehicles exist on swm db:
      | vin              |
      | Vin_TC137847_1   |
    When vehicle sends incorrect inventory via API:
      | vin            | sequence   |
      | Vin_TC137847_1 | <sequence> |
    Then proper response is returned:
      | Status | Code             | Message        |
      | 400    | vd.invalid.input | <errorMessage> |

    Examples:
      | sequence     | errorMessage                                                                                                                                            |
      | abc          | Cannot deserialize value of type `int` from String "abc": not a valid `int` value                                                                       |
      | ''           | Cannot deserialize value of type `int` from String "''": not a valid `int` value                                                                        |
      | -123         | Input sequence must be positive or zero for old vehicle                                                                                                 |
      | -12345678901 | Cannot deserialize value of type `int` from String "-12345678901": Overflow: numeric value (-12345678901) out of range of int (-2147483648 -2147483647) |

  @TC137847-4 @Negative
  Scenario Outline: rainy day updates inventory via API with <report type> validations <error message>
    Given following vehicles exist on swm db:
      | vin            |
      | Vin_TC137847_4 |
    When vehicle sends incorrect inventory via API:
      | vin            | inventoryType |
      | Vin_TC137847_4 | <report type> |
    Then proper response is returned:
      | Status | Code             | Message         |
      | 400    | vd.invalid.input | <error message> |

    Examples:
      | report type  | error message  |
      | [blank]      | Cannot coerce empty String ("") to `com.harman.fod.vehicledata.endpoint.common.enums.InventoryType` value                                                                                                                                                                |
      | ''           | Cannot deserialize value of type `com.harman.fod.vehicledata.endpoint.common.enums.InventoryType` from String "''": not one of the values accepted for Enum class: [HW_PARTIAL, LAST_SEEN, SETTINGS_PARTIAL, SW_PARTIAL, SW_FULL, SETTINGS_FULL, REGISTRY, HW_FULL]      |
      | null         | Cannot deserialize value of type `com.harman.fod.vehicledata.endpoint.common.enums.InventoryType` from String "null": not one of the values accepted for Enum class: [HW_PARTIAL, LAST_SEEN, SETTINGS_PARTIAL, SW_PARTIAL, SW_FULL, SETTINGS_FULL, REGISTRY, HW_FULL]    |
      | abc          | Cannot deserialize value of type `com.harman.fod.vehicledata.endpoint.common.enums.InventoryType` from String "abc": not one of the values accepted for Enum class: [HW_PARTIAL, LAST_SEEN, SETTINGS_PARTIAL, SW_PARTIAL, SW_FULL, SETTINGS_FULL, REGISTRY, HW_FULL]     |

  @TC137952
  Scenario: vehicle sends updated SW_FULL/SW_PARTIAL inventory without SW with different complianceIds and timestamp
    Given following vehicles exist on swm db:
      | vin            |
      | Vin_TC137952_1 |
      | Vin_TC137952_2 |
    And vehicle sends create inventory via API:
      | vin            |
      | Vin_TC137952_1 |
      | Vin_TC137952_2 |
    When vehicle sends updated inventory "updateVehicleDataWithoutSW.json" via API:
      | vin            | timestamp  | sequence | inventoryType |
      | Vin_TC137952_1 | 1234567    | 2        | SW_FULL       |
    And vehicle sends updated inventory "updateVehicleDataWithoutSW.json" via API:
      | vin            | timestamp  | sequence | inventoryType |
      | Vin_TC137952_2 | 1234567    | 2        | SW_PARTIAL    |
    Then the vehicle data updated for "Vin_TC137952_1":
      | nodeAddress | missedSequence | complianceIds | lastSeen                | lastReported            | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | abc123        | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | 0001-1111  | 1111         | true           |
    And inventory with following ECU and software exists for "Vin_TC137952_2":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | lastSeen                | lastReported            | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1       | abc123        | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |                         |                         |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               |                         |                         | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |                         |                         |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               |                         |                         | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |               |                         |                         |            |              |                |

  @TC137956
  Scenario: vehicle sends updated HW_FULL/HW_PARTIAL inventory without non-mandatory fields with different complianceIds and timestamp
    Given following vehicles exist on swm db:
      | vin            |
      | Vin_TC137956_1 |
      | Vin_TC137956_2 |
    And vehicle sends create inventory via API:
      | vin            |
      | Vin_TC137956_1 |
      | Vin_TC137956_2 |
    When vehicle sends updated inventory "updateVehicleDataWithoutNonMandatory.json" via API:
      | vin            | timestamp  | sequence | inventoryType |
      | Vin_TC137956_1 | 1234567    | 2        | HW_FULL       |
    And vehicle sends updated inventory "updateVehicleDataWithoutNonMandatory.json" via API:
      | vin            | timestamp  | sequence | inventoryType |
      | Vin_TC137956_2 | 1234567    | 2        | HW_PARTIAL    |
    Then inventory with following ECU and software exists for "Vin_TC137956_1":
      | nodeAddress | missedSequence | scomoId | version | complianceIds        | lastSeen                | lastReported            | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1       | abc123;;null;;dfe456 | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | 0001-1111  | 1111         | false          |
      | MOST1111    |                | COMPA2  | 2       |                      |                         |                         |            |              |                |
    And inventory with following ECU and software exists for "Vin_TC137956_2":
      | nodeAddress | missedSequence | scomoId | version | complianceIds        | lastSeen                | lastReported            | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1       | abc123;;null;;dfe456 | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | 0001-1111  | 1111         | false          |
      | MOST1111    |                | COMPA2  | 2       |                      |                         |                         |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |                      |                         |                         | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |                      |                         |                         |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |                      |                         |                         | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |                      |                         |                         |            |              |                |

  @TC135394
  Scenario: removing complianceIds from ecu
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC135394_1 |
    And vehicle sends create inventory via API:
      | vin            |
      | VIN_TC135394_1 |
    When vehicle sends updated inventory "updateVehicleDataOnlyComplianceIds.json" via API:
      | vin            | sequence |
      | VIN_TC135394_1 | 2        |
    Then inventory with following ECU and software exists for "VIN_TC135394_1":
      | complianceIds | missedSequence | lastSeen                | lastReported            | managementUnit |
      | aaa111        | false          | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | false          |

 @TC1353261 @Negative
  Scenario Outline: update massage from REST with lower or the same sequence - <vin> <sequence>
    Given following vehicles exist on swm db:
      | vin   |
      | <vin> |
   And vehicle sends updated inventory via API:
     | vin   | sequence |
     | <vin> |  1       |
    When vehicle sends incorrect inventory via API:
     | vin   | sequence   |
     | <vin> | <sequence> |
    Then proper response is returned:
      | Status | Code             | Message                                |
      | 400    | vd.invalid.input | non ordered messages are not supported |

    Examples:
      | vin             | sequence |
      | Vin_TC1353261_1 | 1        |
      | Vin_TC1353261_2 | 0        |

  @TC135393
  Scenario: merging partial inventory with the existing ECUs
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC135393_1 |
      | VIN_TC135393_2 |
    And vehicle sends create inventory via API:
      | vin            |
      | VIN_TC135393_1 |
      | VIN_TC135393_2 |
    When vehicle sends updated inventory "differentNodeAddress.json" via API:
      | vin            | sequence | inventoryType |
      | VIN_TC135393_1 | 2        | SW_FULL       |
    And vehicle sends updated inventory "differentNodeAddress.json" via API:
      | vin            | sequence | inventoryType |
      | VIN_TC135393_2 | 2        | HW_PARTIAL    |
    Then inventory with following ECU and software exists for "VIN_TC135393_1":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA3  | 3.0     | abc123        | 0001-1111  | 1111         | true           |
      | MOST2222    |                | COMPB1  | 1.0     |               | 0001-0000  | 0000         | false          |
      | MOST2222    |                | COMPB2  | 2.0     |               |            |              |                |
      | MOST6666    |                | COMPC1  | 1.0     |               | 0001-3333  | 3333         | false          |
      | MOST6666    |                | COMPC2  | 2.0     |               |            |              |                |
    * inventory with following ECU and software exists for "VIN_TC135393_2":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1       | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |            |              |                |
      | MOST2222    |                | COMPB1  | 1.0     |               | 0001-0000  | 0000         | false          |
      | MOST2222    |                | COMPB2  | 2.0     |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |               |            |              |                |
      | MOST6666    |                | COMPC1  | 1.0     |               | 0001-3333  | 3333         | false          |
      | MOST6666    |                | COMPC2  | 2.0     |               |            |              |                |

  @TC137728
  Scenario: send full/partial inventory message with different nodeAddress in SW and HW
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC137728_1 |
      | VIN_TC137728_2 |
      | VIN_TC137728_3 |
      | VIN_TC137728_4 |
    And vehicle sends create inventory via API:
      | vin            |
      | VIN_TC137728_1 |
      | VIN_TC137728_2 |
      | VIN_TC137728_3 |
      | VIN_TC137728_4 |
    When vehicle sends updated inventory "differentNodeAddresses.json" via API:
      | vin            | sequence | inventoryType |
      | VIN_TC137728_1 | 2        |    SW_FULL    |
    * vehicle sends updated inventory "differentNodeAddresses.json" via API:
      | vin            | sequence | inventoryType |
      | VIN_TC137728_2 | 2        |    SW_PARTIAL |
    * vehicle sends updated inventory "differentNodeAddresses.json" via API:
      | vin            | sequence | inventoryType |
      | VIN_TC137728_3 | 2        |    HW_FULL    |
    * vehicle sends updated inventory "differentNodeAddresses.json" via API:
      | vin            | sequence | inventoryType |
      | VIN_TC137728_4 | 2        |    HW_PARTIAL |
    Then inventory with following ECU and software exists for "VIN_TC137728_1":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1.0     | abc123        | 0001-1111  | 1111         | true           |
      | MOST0000    |                |         |         |               | 0001-0000  | 0000         | true           |
    * inventory with following ECU and software exists for "VIN_TC137728_2":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1.0     | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |               |            |              |                |
      | MOST0000    |                |         |         |               | 0001-0000  | 0000         | true           |
    * inventory with following ECU and software exists for "VIN_TC137728_3":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1       | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |            |              |                |
      | MOST0000    |                |         |         |               | 0001-0000  | 0000         | true           |
    * inventory with following ECU and software exists for "VIN_TC137728_4":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1       | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |               |            |              |                |
      | MOST0000    |                |         |         |               | 0001-0000  | 0000         | true           |

  @TC135431 @Negative
  Scenario: empty 'sequence' field for vehicle that already sent sequence
    Given following vehicles exist on swm db:
      | vin          |
      | VIN_TC135431 |
    And vehicle sends create inventory via API:
      | vin          |
      | VIN_TC135431 |
    When vehicle sends "updateVehicleDateWithoutSequence.json" inventory via API:
      | vin          | timestamp |
      | VIN_TC135431 | 12345678  |
    Then proper response is returned:
      | Status | Code             | Message                                |
      | 400    | vd.invalid.input | non ordered messages are not supported |

  @TC135431-1
  Scenario: empty 'sequence' field in create and update with the newer timestamp
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC135431_1 |
    When vehicle sends updated inventory "updateVehicleDateWithoutSequence.json" via API:
      | vin            |
      | VIN_TC135431_1 |
    And vehicle sends updated inventory "updateVehicleDateWithoutSequence.json" via API:
      | vin            | timestamp |
      | VIN_TC135431_1 | 12345678  |
    Then inventory with following ECU and software exists for "VIN_TC135431_1":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1.0     | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA3  | 3.0     |               |            |              |                |
      | MOST1111    |                | COMPA4  | 4.0     |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1.0     |               | 0001-3333  | 3333         | true           |
      | MOST3333    |                | COMPC2  | 2.0     |               |            |              |                |
      | MOST3333    |                | COMPC3  | 3.0     |               |            |              |                |
      | MOST4444    |                | COMPD1  | 1.0     |               | 0001-4444  | 4444         | false          |
      | MOST4444    |                | COMPD2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE1  | 1.0     |               | 0001-5555  | 5555         | false          |
      | MOST5555    |                | COMPE2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE3  | 3.0     |               |            |              |                |

  @TC135431-2 @Negative
  Scenario: empty 'sequence' field in create and update with the lower timestamp
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC135431_2 |
    And vehicle sends updated inventory via API:
      | vin            | timestamp    | inventoryType |
      | VIN_TC135431_2 | 1702824601   | SW_FULL       |
    When vehicle sends incorrect inventory via API:
      | vin            | timestamp   | inventoryType |
      | VIN_TC135431_2 | 1702822202  | SW_PARTIAL    |
    Then proper response is returned:
      | Status | Code             | Message                                |
      | 400    | vd.invalid.input | non ordered messages are not supported |

  @TC140393-1 @Negative
  Scenario: update vehicle in swm db in status different than new/active
    Given following vehicles exist on swm db:
      | vin            | status    |
      | VIN_TC140393_1 | TO_DELETE |
    When vehicle sends incorrect inventory via API:
      | vin            | sequence |
      | VIN_TC140393_1 | 3        |
    Then proper response is returned:
      | Status | Code             | Message                                                                    |
      | 400    | vd.invalid.input | Vehicle vin_tc140393_1 doesnt exist in the system. Inventory wont be saved |

  @TC140393-2 @Negative
  Scenario: update new vehicle not in swm db
    When vehicle sends incorrect inventory via API:
      | vin            | sequence |
      | VIN_TC140393_2 | 3        |
    Then proper response is returned:
      | Status | Code             | Message                                                                    |
      | 400    | vd.invalid.input | Vehicle vin_tc140393_2 doesnt exist in the system. Inventory wont be saved |

  @TC145439
  Scenario: mixed inventory update
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC145439_1 |
      | VIN_TC145439_2 |
      | VIN_TC145439_3 |
    And vehicle sends create inventory via API:
      | vin            |
      | VIN_TC145439_1 |
      | VIN_TC145439_2 |
      | VIN_TC145439_3 |
    When vehicle sends updated inventory via API:
      | vin            | sequence | inventoryType         |
      | VIN_TC145439_1 | 2        | HW_FULL,SW_PARTIAL    |
      | VIN_TC145439_2 | 2        | HW_FULL,SW_FULL       |
      | VIN_TC145439_3 | 2        | HW_PARTIAL,SW_PARTIAL |
    Then inventory with following ECU and software exists for "VIN_TC145439_1":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1.0     | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |            |              |                |
      | MOST1111    |                | COMPA3  | 3.0     |               |            |              |                |
      | MOST1111    |                | COMPA4  | 4.0     |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1.0     |               | 0001-3333  | 3333         | true           |
      | MOST3333    |                | COMPC2  | 2.0     |               |            |              |                |
      | MOST3333    |                | COMPC3  | 3.0     |               |            |              |                |
      | MOST4444    |                | COMPD1  | 1.0     |               | 0001-4444  | 4444         | false          |
      | MOST4444    |                | COMPD2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE1  | 1.0     |               | 0001-5555  | 5555         | false          |
      | MOST5555    |                | COMPE2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE3  | 3.0     |               |            |              |                |
    And inventory with following ECU and software exists for "VIN_TC145439_2":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1.0     | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA3  | 3.0     |               |            |              |                |
      | MOST1111    |                | COMPA4  | 4.0     |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1.0     |               | 0001-3333  | 3333         | true           |
      | MOST3333    |                | COMPC2  | 2.0     |               |            |              |                |
      | MOST3333    |                | COMPC3  | 3.0     |               |            |              |                |
      | MOST4444    |                | COMPD1  | 1.0     |               | 0001-4444  | 4444         | false          |
      | MOST4444    |                | COMPD2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE1  | 1.0     |               | 0001-5555  | 5555         | false          |
      | MOST5555    |                | COMPE2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE3  | 3.0     |               |            |              |                |
    And inventory with following ECU and software exists for "VIN_TC145439_3":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1.0     | abc123        | 0001-1111  | 1111         | true           |
      | MOST1111    |                | COMPA2  | 2       |               |            |              |                |
      | MOST1111    |                | COMPA3  | 3.0     |               |            |              |                |
      | MOST1111    |                | COMPA4  | 4.0     |               |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |            |              |                |
      | MOST3333    |                | COMPC1  | 1.0     |               | 0001-3333  | 3333         | true           |
      | MOST3333    |                | COMPC2  | 2.0     |               |            |              |                |
      | MOST3333    |                | COMPC3  | 3.0     |               |            |              |                |
      | MOST4444    |                | COMPD1  | 1.0     |               | 0001-4444  | 4444         | false          |
      | MOST4444    |                | COMPD2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE1  | 1.0     |               | 0001-5555  | 5555         | false          |
      | MOST5555    |                | COMPE2  | 2.0     |               |            |              |                |
      | MOST5555    |                | COMPE3  | 3.0     |               |            |              |                |

  @TC145482 @Negative
  Scenario Outline: mixed inventory update negative - <inventoryType> <message>
    Given following vehicles exist on swm db:
      | vin      |
      | TC145482 |
    When vehicle sends incorrect inventory via API:
      | vin      | sequence | inventoryType    |
      | TC145482 | 2        | <inventoryType>  |
    Then proper response is returned:
      | Status | Code             | Message   |
      | 400    | vd.invalid.input | <message> |

    Examples:
      | inventoryType              | message             |
      | HW_PARTIAL,SW_FULL         | Not supported types |
      | HW_PARTIAL,SW_FULL,HW_FULL | Not supported types |
      | INVENTORY,SW_FULL          | Cannot deserialize value of type `com.harman.fod.vehicledata.endpoint.common.enums.InventoryType` from String "INVENTORY" |
