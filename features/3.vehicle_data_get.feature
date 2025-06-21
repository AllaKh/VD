@VD
Feature: Vehicle Data Get

  @TC134507
  Scenario Outline: Vehicle Data Get by VehicleID with - <projection> <sequence>
    Given following vehicles exist on swm db:
      | vin          |
      | VIN_TC134507 |
    And vehicle sends updated inventory via API:
      | vin          | sequence   |
      | VIN_TC134507 | <sequence> |
    When vehicle sends getByID request with "<projection>" projection
    Then proper vehicle data exists:
      | nodeAddress | missedSequence | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit | lastSeen                | lastReported            |
      | MOST1111    | false          | COMPA1  | 1.0     | abc123        | 0001-1111  | 1111         | true           | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 |
      | MOST1111    |                | COMPA3  | 3.0     |               |            |              |                |                         |                         |
      | MOST1111    |                | COMPA4  | 4.0     |               |            |              |                |                         |                         |
      | MOST3333    |                | COMPC1  | 1.0     |               | 0001-3333  | 3333         | true           |                         |                         |
      | MOST3333    |                | COMPC2  | 2.0     |               |            |              |                |                         |                         |
      | MOST3333    |                | COMPC3  | 3.0     |               |            |              |                |                         |                         |
      | MOST4444    |                | COMPD1  | 1.0     |               | 0001-4444  | 4444         | false          |                         |                         |
      | MOST4444    |                | COMPD2  | 2.0     |               |            |              |                |                         |                         |
      | MOST5555    |                | COMPE1  | 1.0     |               | 0001-5555  | 5555         | false          |                         |                         |
      | MOST5555    |                | COMPE2  | 2.0     |               |            |              |                |                         |                         |
      | MOST5555    |                | COMPE3  | 3.0     |               |            |              |                |                         |                         |

    Examples:
      | sequence | projection |
      | 1        | ALL        |
      | 2        |            |

  @TC134507-1
  Scenario: Vehicle Data Get by VehicleID with projection COMPLIANCE_IDS
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC134507_1 |
    And vehicle sends updated inventory via API:
      | vin            |
      | VIN_TC134507_1 |
    When vehicle sends getByID request with "COMPLIANCE_IDS" projection
    Then proper vehicle data exists:
      | complianceIds | lastSeen                | lastReported            | missedSequence |
      | abc123        | 1970-01-01 02:20:34.567 | 1970-01-01 02:20:34.567 | false          |

  @TC134507-2 @Negative
  Scenario: Vehicle Data Get by VehicleID with wrong projection
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC134507_2 |
    And vehicle sends updated inventory via API:
      | vin            |
      | VIN_TC134507_2 |
    Then client is calling getByID request with wrong projection

  @TC134507-3 @Negative
  Scenario: Vehicle Data Get by VehicleID not present
    When client is calling getByID for not existing vehicle
    Then vehicles don't present in the DB:
      | 555 |

  @TC138730-1
  Scenario: Get vehicle by Id
    Given following vehicles exist on swm db:
      | vin            | creationTime | status    | domainIds | vehicleModelId | specificAttributes |
      | VIN_TC138730_1 | 1698692000   | Active    | 877634    | 789456         | 1:b                |
    And vehicle sends updated inventory via API:
      | vin            | sequence | inventoryType |
      | VIN_TC138730_1 |   3      | SW_FULL       |
    When get vehicle VIN_TC138730_1 by Id
    Then response of getting vehicle by Id has the following details:
      | devId          | devIdBK         | creationTime | status | complianceIds | lastSeen | lastReported |  specificAttributes | accountId | deviceClassId |
      | VIN_TC138730_1 | vin_tc138730_1  | 1698692      | Active |  abc123       |  123456  |  123456      |  1:b                |  877634   |  789456       |

  @TC138730-2 @Negative
  Scenario: Get vehicle by Id not found
    When get vehicle VIN_TC138730_3 by Id
    Then proper response is returned:
      | Status | Code         | Message    |
      | 404    | vd.not.found | Not found. |
