@VD
Feature: Vehicle Data Creation

  @TC154624
  Scenario Outline: vehicle sends message to - <broker>
    Given following vehicles exist on swm db:
      | vin                    |
      | VIN_TC12345_1_<broker> |
      | VIN_TC12345_2_<broker> |
      | VIN_TC12345_3_<broker> |
      | VIN_TC12345_4_<broker> |
    When vehicle inventory updated via "<broker>":
      | vin                    | inventoryType | requestSource   |
      | VIN_TC12345_1_<broker> |  SW_FULL      | <requestSource> |
    * wait 1 sec for inventory to be merged
    And vehicle inventory updated via "<broker>":
      | vin                    | inventoryType | requestSource   |
      | VIN_TC12345_2_<broker> |  HW_FULL      | <requestSource> |
    * wait 1 sec for inventory to be merged
    And vehicle inventory updated via "<broker>":
      | vin                    | inventoryType  | requestSource   |
      | VIN_TC12345_3_<broker> | SW_PARTIAL     | <requestSource> |
    * wait 1 sec for inventory to be merged
    And vehicle inventory updated via "<broker>":
      | vin                    | inventoryType  | requestSource   |
      | VIN_TC12345_4_<broker> | HW_PARTIAL     | <requestSource> |
    * wait 10 sec for inventory to be merged
    Then inventory with following ECU and software exists for "VIN_TC12345_1_<broker>":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | lastSeen                | lastReported            | partNumber | serialNumber | managementUnit |
      | MOST1111    | false          | COMPA1  | 1       | aaa111        | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | 0001-1111  | 1111         | false          |
      | MOST1111    |                | COMPA2  | 2       |               |                         |                         |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               |                         |                         | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |                         |                         |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               |                         |                         | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |               |                         |                         |            |              |                |
    And inventory with following ECU and software exists for "VIN_TC12345_2_<broker>":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | lastSeen                | lastReported            | partNumber | serialNumber | managementUnit |
      | MOST1111    | true           | COMPA1  | 1       | aaa111        | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | 0001-1111  | 1111         | false          |
      | MOST1111    |                | COMPA2  | 2       |               |                         |                         |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               |                         |                         | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |                         |                         |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               |                         |                         | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |               |                         |                         |            |              |                |
    And inventory with following ECU and software exists for "VIN_TC12345_3_<broker>":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | lastSeen                | lastReported            | partNumber | serialNumber | managementUnit |
      | MOST1111    | true           | COMPA1  | 1       | aaa111        | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | 0001-1111  | 1111         | false          |
      | MOST1111    |                | COMPA2  | 2       |               |                         |                         |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               |                         |                         | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |                         |                         |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               |                         |                         | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |               |                         |                         |            |              |                |
    And inventory with following ECU and software exists for "VIN_TC12345_4_<broker>":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | lastSeen                | lastReported            | partNumber | serialNumber | managementUnit |
      | MOST1111    | true           | COMPA1  | 1       | aaa111        | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | 0001-1111  | 1111         | false          |
      | MOST1111    |                | COMPA2  | 2       |               |                         |                         |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               |                         |                         | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |                         |                         |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               |                         |                         | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |               |                         |                         |            |              |                |

    Examples:
      | broker                | requestSource |
      | MQTT                  | VEHICLE       |
      | InventoryUpdatesQueue | SWM           |
      | VehicleMessageQueue   | SWM           |

  @TC135134 @Negative
  Scenario Outline: vehicle sends wrong message to - <broker> <inventoryType> <vin> <timestamp> <sequence> <signature>
    Given following vehicles exist on swm db:
      | vin                     |
      | VIN_TC135134_1_<broker> |
      | <vin>                   |
      | VIN_TC135134_2_<broker> |
      | VIN_TC135134_3_<broker> |
      | VIN_TC135134_4_<broker> |
    When vehicle inventory updated via "<broker>":
      | vin                     | inventoryType   | signature | requestSource   |
      | VIN_TC135134_1_<broker> | <inventoryType> | 123456    | <requestSource> |
    * wait 1 sec for inventory to be merged
    * vehicle inventory updated via "<broker>":
      | vin   | signature | requestSource   |
      | <vin> | 123456    | <requestSource> |
    * wait 1 sec for inventory to be merged
    * vehicle inventory updated via "<broker>":
      | vin                     | timestamp   | signature | requestSource   |
      | VIN_TC135134_2_<broker> | <timestamp> | 123456    | <requestSource> |
    * wait 1 sec for inventory to be merged
    * vehicle inventory updated via "<broker>":
      | vin                     | sequence   | signature | requestSource   |
      | VIN_TC135134_3_<broker> | <sequence> | 123456    | <requestSource> |
    * wait 1 sec for inventory to be merged
    * vehicle inventory updated via "<broker>":
      | vin                     | sequence | signature   | requestSource   |
      | VIN_TC135134_4_<broker> | 1        | <signature> | <requestSource> |
    * wait 1 sec for inventory to be merged
    Then vehicles don't present in the DB:
      | VIN_TC135134_1_<broker> |
      | <vin>                   |
      | VIN_TC135134_2_<broker> |
      | VIN_TC135134_3_<broker> |
      | VIN_TC135134_4_<broker> |

    Examples:
      | broker               | inventoryType             | signature   | sequence    | timestamp | requestSource   | vin        |
      | MQTT                 | ["SETTINGS_FULL"]         | abc         | abc         | abc       | <requestSource> | [blank]    |
      | MQTT                 | ["SETTINGS_PARTIAL"]      | ''          | ''          | [blank]   | <requestSource> | ''         |
      | MQTT                 | ["SW_FULL", "HW_PARTIAL"] | -123        | -123        | ''        | <requestSource> | !@#$%^&*(+ |
      | MQTT                 | [blank]                   | !@#$%^&*()_ | 12345678901 | -123      | <requestSource> | 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678905555567 |
      | InventoryUpdatesQueue| ["SETTINGS_FULL"]         | abc         | abc         | abc       | <requestSource> | [blank]    |
      | InventoryUpdatesQueue| ["SETTINGS_PARTIAL"]      | ''          | ''          | [blank]   | <requestSource> | ''         |
      | InventoryUpdatesQueue| ["SW_FULL", "HW_PARTIAL"] | -123        | -123        | ''        | <requestSource> | !@#$%^&*(+ |
      | InventoryUpdatesQueue| [blank]                   | !@#$%^&*()_ | 12345678901 | -123      | <requestSource> | 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678905555567 |
      | VehicleMessageQueue  | ["SETTINGS_FULL"]         | abc         | abc         | abc       | <requestSource> | [blank]    |
      | VehicleMessageQueue  | ["SETTINGS_PARTIAL"]      | ''          | ''          | [blank]   | <requestSource> | ''         |
      | VehicleMessageQueue  | ["SW_FULL", "HW_PARTIAL"] | -123        | -123        | ''        | <requestSource> | !@#$%^&*(+ |
      | VehicleMessageQueue  | [blank]                   | !@#$%^&*()_ | 12345678901 | -123      | <requestSource> | 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678905555567 |

  @TC140356
  Scenario Outline: vehicle sends registry message to - <broker>
    Given following vehicles exist on swm db:
      | vin                     |
      | VIN_TC140356_1_<broker> |
      | VIN_TC140356_2_<broker> |
    And vehicle sends "registry_vehicle_massage.json" inventory update via "<broker>":
      | vin                     | inventoryType | requestSource   |
      | VIN_TC140356_1_<broker> | REGISTRY      | <requestSource> |
    * wait 1 sec for inventory to be merged
    And vehicle inventory updated via "<broker>":
      | vin                     | inventoryType | requestSource   |
      | VIN_TC140356_2_<broker> |  HW_FULL      | <requestSource> |
    * wait 10 sec for inventory to be merged
    And vehicle inventory updated via "<broker>":
      | vin                     | inventoryType | requestSource   |
      | VIN_TC140356_2_<broker> |  REGISTRY     | <requestSource> |
    * wait 10 sec for inventory to be merged
    Then vehicles don't present in the DB:
      | VIN_TC140356_1_<broker> |
    And inventory with following ECU and software exists for "VIN_TC140356_2_<broker>":
      | nodeAddress | missedSequence | scomoId | version | complianceIds | lastSeen                | lastReported            | partNumber | serialNumber | managementUnit |
      | MOST1111    | true           | COMPA1  | 1       | aaa111        | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | 0001-1111  | 1111         | false          |
      | MOST1111    |                | COMPA2  | 2       |               |                         |                         |            |              |                |
      | MOST2222    |                | COMPB1  | 1       |               |                         |                         | 0001-2222  | 2222         | false          |
      | MOST2222    |                | COMPB2  | 2       |               |                         |                         |            |              |                |
      | MOST3333    |                | COMPC1  | 1       |               |                         |                         | 0001-3333  | 3333         | false          |
      | MOST3333    |                | COMPC2  | 2       |               |                         |                         |            |              |                |

    Examples:
      | broker               | requestSource   |
      | VehicleMessageQueue  | SWM             |