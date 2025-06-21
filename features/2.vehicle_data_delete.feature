@VD
Feature: Vehicle Data Delete

  @TC137404
  Scenario: sunny day delete vehicles from DB by VIN
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC137404_1 |
      | VIN_TC137404_2 |
      | VIN_TC137404_3 |
      | VIN_TC137404_4 |
    And vehicle sends create inventory via API:
      | vin            |
      | VIN_TC137404_1 |
      | VIN_TC137404_2 |
      | VIN_TC137404_3 |
      | VIN_TC137404_4 |
    When vehicles are deleted:
      | VIN_TC137404_1  |
      | vin_TC137404_2  |
      | VIN_TC137404_3  |
      | VIN_TC137404_5  |
    Then vehicles don't present in the DB:
      | VIN_TC137404_1 |
      | VIN_TC137404_2 |
      | VIN_TC137404_3 |
      | VIN_TC137404_5 |
    And inventory with following ECU and software exists for "VIN_TC137404_4":
      | nodeAddress | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | COMPA1  | 1       | aaa111        | 0001-1111  | 1111         | false          |
      | MOST1111    | COMPA2  | 2       |               |            |              |                |
      | MOST2222    | COMPB1  | 1       |               | 0001-2222  | 2222         | false          |
      | MOST2222    | COMPB2  | 2       |               |            |              |                |
      | MOST3333    | COMPC1  | 1       |               | 0001-3333  | 3333         | false          |
      | MOST3333    | COMPC2  | 2       |               |            |              |                |

  @TC135698
  Scenario: Nothing was deleted
    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC135698_1 |
    And vehicle sends create inventory via API:
      | vin            |
      | VIN_TC135698_1 |
    When vehicles are deleted:
      | VIN_TC135698_2 |
      | vin_TC135698_3 |
    Then vehicles don't present in the DB:
      | VIN_TC135698_2 |
      | VIN_TC135698_3 |
    And inventory with following ECU and software exists for "VIN_TC135698_1":
      | nodeAddress | scomoId | version | complianceIds | partNumber | serialNumber | managementUnit |
      | MOST1111    | COMPA1  | 1       | aaa111        | 0001-1111  | 1111         | false          |
      | MOST1111    | COMPA2  | 2       |               |            |              |                |
      | MOST2222    | COMPB1  | 1       |               | 0001-2222  | 2222         | false          |
      | MOST2222    | COMPB2  | 2       |               |            |              |                |
      | MOST3333    | COMPC1  | 1       |               | 0001-3333  | 3333         | false          |
      | MOST3333    | COMPC2  | 2       |               |            |              |                |

  @TC135128 @Negative
  Scenario Outline: rainy day delete vehicles from DB by VIN - <vin>
    When vehicle wasn't deleted:
      | <vin> |
    Then proper response is returned:
      | Status | Code             |
      | 400    | vd.invalid.input |
    And vehicles don't present in the DB:
      | <vin> |

    Examples:
      | vin        |
      | [blank]    |
      |            |
      | ''         |
      | !@#$%^&*(+ |
      | 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678905555567 |