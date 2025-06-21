@VD
Feature: Vehicle Data Filter

  @TC140297-1
  Scenario: filter vehicles by empty filter
    Given following vehicles exist on swm db:
      | vin              | creationTime | status    | domainIds | vehicleModelId |
      | VIN_TC140297-1_1 | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC140297-1_2 | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC140297-1_3 | 1698682311   | New       | 877634    | 789456         |
      | VIN_TC140297-1_4 | 1698682310   | To_delete | 877634    | 789456         |
      | VIN_TC140297-1_5 | 1698682310   | Register  | 877634    | 789456         |
      | VIN_TC140297-1_6 | 1698682310   | Active    | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin              |
      | VIN_TC140297-1_1 |
      | VIN_TC140297-1_2 |
      | VIN_TC140297-1_3 |
    * vehicle inventory updated via "InventoryUpdatesQueue":
      | vin              | requestSource |
      | VIN_TC140297-1_4 | SWM           |
    * wait 1 sec for inventory to be merged
    * vehicle sends inventory update via MQTT:
      | vin              | requestSource |
      | VIN_TC140297-1_5 | VEHICLE       |
    * wait 1 sec for inventory to be merged
    * vehicle inventory updated via "InventoryUpdatesQueue":
      | vin              | requestSource |
      | VIN_TC140297-1_6 | SWM           |
    *  wait 1 sec for inventory to be merged
    When get all by empty filter with the following parameters:
      | sort     |
      | LastSeen |
    Then the response is:
      | vin              | vehicleId  | creationTime | status    | domainId | complianceIds | lastSeen | lastReported | vehicleModelId |
      | VIN_TC140297-1_1 | 2002999956 | 1698682      | Active    | 877634   | aaa111        | 1234567  | 1234567      | 789456         |
      | VIN_TC140297-1_2 | 2002999955 | 1698682      | Active    | 877634   | aaa111        | 1234567  | 1234567      | 789456         |
      | VIN_TC140297-1_3 | 2002999954 | 1698682      | New       | 877634   | aaa111        | 1234567  | 1234567      | 789456         |
      | VIN_TC140297-1_4 | 2002999953 | 1698682      | To_delete | 877634   |               | 0        | 0            | 789456         |
      | VIN_TC140297-1_5 | 2002999952 | 1698682      | Register  | 877634   |               | 0        | 0            | 789456         |
      | VIN_TC140297-1_6 | 2002999951 | 1698682      | Active    | 877634   | aaa111        | 1234567  | 1234567      | 789456         |
    And response order is by LastSeen field

  @TC140297
  Scenario: filter vehicles by different parameters
    Given following vehicles exist on swm db:
      | vin             | creationTime | status    | domainIds | vehicleModelId | specificAttributes |
      # Not match vin filter
      | VIN_TC140297_1  | 1698682000   | Active    | 877634    | 789456         |                    |
      # Match the filter
      | VIN_TC140297_2  | 1698682000   | Active    | 877634    | 789456         | 1:b                |
      # Not match creation time
      | VIN_TC140297_3  | 1698684000   | Active    | 877634    | 789456         |                    |
      # Not match status (To_delete)
      | VIN_TC140297_4  | 1698682000   | To_delete | 877634    | 789456         |                    |
      # Not match status (Register)
      | VIN_TC140297_5  | 1698682000   | Register  | 877634    | 789456         |                    |
      # Not match status (New)
      | VIN_TC140297_6  | 1698682000   | New       | 877634    | 789456         |                    |
      # Not match ECU serial number (no inventory at all)
      | VIN_TC140297_7  | 1698682000   | Active    | 877634    | 789456         |                    |
      # Not match vehicle model ID
      | VIN_TC140297_8  | 1698682000   | Active    | 877634    | 789457         |                    |
      # Not match domain ID
      | VIN_TC140297_9  | 1698682000   | Active    | 877635    | 789456         |                    |
      # Not match specific attribute
      | VIN_TC140297_10 | 1698682000   | Active    | 877634    | 789456         | 1:a                |
    And vehicle sends create inventory via API:
      | vin            |
      | VIN_TC140297_1 |
      | VIN_TC140297_2 |
      | VIN_TC140297_3 |
      | VIN_TC140297_8 |
      | VIN_TC140297_9 |
      | VIN_TC140297_10 |
    And vehicle inventory updated via "InventoryUpdatesQueue":
      | vin            | requestSource |
      | VIN_TC140297_4 | SWM           |
    * wait 1 sec for inventory to be merged
    * vehicle sends inventory update via MQTT:
      | vin            | requestSource |
      | VIN_TC140297_5 | VEHICLE       |
    * wait 1 sec for inventory to be merged
    * vehicle inventory updated via "InventoryUpdatesQueue":
      | vin            | requestSource |
      | VIN_TC140297_6 | SWM           |
    * wait 10 sec for inventory to be merged
    When get list with parameters according to filter with "VEHICLE" projection:
      | vin                 | ecuSerialNumber | creationTime | status | domainId | vehicleModelId | vehicleId                                                                   | specificAttributes |
      | VIN_TC140297_[2-10] | 1111            | 1698683000   | Active | 877634   | 789456         | 2089535049,2089535051,2089535052,2089535053,2089535054,2089535056,351077096 | 1:b                |
    Then the response is:
      | vin            | vehicleId  | creationTime | status | domainId | complianceIds | lastSeen | lastReported | vehicleModelId | specificAttributes |
      | VIN_TC140297_2 | 2089535049 | 1698682      | Active | 877634   | aaa111        | 1234567  | 1234567      | 789456         | 1:b                |
    And response order is by vin field
    And response order is by LastSeen field

  @TC140297-2 @Negative
  Scenario: filter non-existing vehicle
    When get list with parameters according to filter with "VEHICLE" projection:
      | vin            |
      | VIN_TC140297-2 |
    Then the response is:
      |  |

  @TC143645
  Scenario: filter vehicles with BASIC projection
    Given following vehicles exist on swm db:
      | vin                 | creationTime | status    | domainIds | vehicleModelId |
      | VIN_TC143645_1      | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143645_2      | 1698682310   | Active    | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin                 |
      | VIN_TC143645_1      |
      | VIN_TC143645_2      |
    And get list with parameters according to filter with "BASIC" projection:
      | vin                 |
      | VIN_TC143645_[1-2]  |
    Then the response includes only BASIC projection fields:
      | vin                 | vehicleId    | complianceIds | lastSeen | lastReported  | creationTime |
      | VIN_TC143645_1      | 2116001588   | aaa111        | 1234567  | 1234567       | 1698682      |
      | VIN_TC143645_2      | 2116001587   | aaa111        | 1234567  | 1234567       | 1698682      |

  @TC143646
  Scenario: filter vehicles with page size zero
    Given following vehicles exist on swm db:
      | vin               | creationTime | status    | domainIds | vehicleModelId |
      | VIN_TC143646_1    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_2    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_3    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_4    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_5    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_6    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_7    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_8    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_9    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_10   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_11   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_12   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_13   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_14   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_15   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_16   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_17   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_18   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_19   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_20   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_21   | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143646_22   | 1698682310   | Active    | 877634    | 789456         |
    When get vehicles by filter with page size zero
    Then validate no paging is applied to filter api response

  @TC143647
  Scenario: filter vehicles with inventory
    Given following vehicles exist on swm db:
      | vin               | creationTime | status    | domainIds | vehicleModelId |
      | VIN_TC143647_1    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143647_2    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143647_3    | 1698682310   | Active    | 877634    | 789456         |
      | VIN_TC143647_4    | 1698682310   | Active    | 877634    | 789456         |
    And vehicle sends create inventory via API:
      | vin             |
      | VIN_TC143647_1  |
      | VIN_TC143647_2  |
    And vehicle sends "remove_ecu_from_inventory.json" inventory update via "MQTT":
      | vin             | requestSource |
      | VIN_TC143647_2  | VEHICLE       |
    * wait 1 sec for inventory to be merged
    And get vehicles inventory filter with the following parameters:
      | vin                                                    | vehicleId                     |
      | VIN_TC143647_1,VIN_TC143647_2,VIN_TC143647_NOT_EXIST   | 2115999666,2115999665,1234567 |
    Then validate vehicle inventory in filter response:
      | vin            | serialNumber   | partNumber                     | nodeAddress                | managementUnit    | scomoId                                          | version        |
      | VIN_TC143647_1 | 1111,2222,3333 | 0001-1111,0001-2222,0001-3333  | MOST1111,MOST2222,MOST3333 | false,false,false | COMPA1,COMPA2,COMPB1,COMPB2,COMPC1,COMPC2        | 1,2,1,2,1,2    |
      | VIN_TC143647_2 | 1111,3333,4444 | 0001-1111,0001-3333,0001-4444  | MOST1111,MOST3333,MOST4444 | false,false,false | COMPA1,COMPA2,COMPC1,COMPC2,COMPD1,COMPD2,COMPD3 | 1,2,1,2,1,2,3  |

  @TC143647-1
  Scenario: filter vehicles with empty filters return 200
    And get vehicles inventory filter with the following parameters:
      | vin | vehicleId |
      |     |           |

  @TC144884
  Scenario: aggregate vehicles per account by all filter fields
    Given following vehicles exist on swm db:
      | vin             | creationTime | status    | domainIds | vehicleModelId | specificAttributes |
      # match all filter fields
      | VIN_TC144884_1  | 1698692000   | Active    | 877634    | 789456         | 1:b                |
      # match all filter fields
      | VIN_TC144884_2  | 1698692000   | Active    | 877635    | 789456         | 1:b                |
      # match all filter fields
      | VIN_TC144884_3  | 1698692000   | Active    | 877635    | 789456         | 1:b                |
      # Not match status (New)
      | VIN_TC144884_4  | 1698682000   | New       | 877634    | 789456         |                    |
      # Not match creation time
      | VIN_TC144884_5  | 1698662000   | New       | 877634    | 789456         |                    |
      # Not match vehicle model ID
      | VIN_TC144884_6  | 1698682000   | Active    | 877634    | 789457         |                    |
      # Not match specific attribute
      | VIN_TC144884_7  | 1698682000   | Active    | 877634    | 789456         |  1:a               |
      # Not match vin
      | VIN_TC144884_8 | 1698682000   | Active     | 877634    | 789456         |                    |
    And vehicle sends updated sw inventory via API:
      | vin              | scomoId | version |
      | VIN_TC144884_1   | SCOMO1  | 2.0     |
      | VIN_TC144884_2   | SCOMO1  | 2.0     |
      | VIN_TC144884_3   | SCOMO1  | 2.0     |
      | VIN_TC144884_4   | SCOMO1  | 2.0     |
      | VIN_TC144884_5   | SCOMO1  | 2.0     |
      | VIN_TC144884_6   | SCOMO1  | 2.0     |
      | VIN_TC144884_7   | SCOMO1  | 2.0     |
      | VIN_TC144884_8   | SCOMO1  | 2.0     |
    When get vehicle aggregation by account according to filter:
      | vin                 |  exactVins                                    | creationTime  | domainId      | status  | vehicleModelId | specificAttributes |  ecuSerialNumber  | softwareList | ecu                       |
      | VIN_TC144884_[1-7]  |  VIN_TC144884_1,VIN_TC144884_2,VIN_TC144884_3 | 1698683000    | 877634,877635 | Active  | 789456         | 1:b                |  1111             | SCOMO1,2.0   | MOST1111,0001-1111,EXACT  |
    Then the vehicle aggregation by accountId response is:
      | 877634 | 1  |
      | 877635 | 2  |

  @TC144884_1
  Scenario: aggregate vehicles per account by filter no match
    Given following vehicles exist on swm db:
      | vin               | creationTime | status    | domainIds | vehicleModelId |
      | VIN_TC144884_1_1  | 1698692000   | Active    | 877634    | 789456         |
    And vehicle sends updated sw inventory via API:
      | vin                | scomoId | version |
      | VIN_TC144884_1_1   | SCOMO1  | 2.0     |
    When get vehicle aggregation by account according to filter:
      | vin                 |
      | VIN_TC144884_3_1    |
    Then the vehicle aggregation by accountId response is empty

  @TC145365
  Scenario: get used ecus by all filter fields
    Given following vehicles exist on swm db:
      | vin             | creationTime | status    | domainIds | vehicleModelId | specificAttributes |
      # match all filter fields
      | VIN_TC145365_1  | 1698692000   | Active    | 877634    | 789456         | 1:b                |
      # match all filter fields
      | VIN_TC145365_2  | 1698692000   | Active    | 877635    | 789456         | 1:b                |
      # match all filter fields
      | VIN_TC145365_3  | 1698692000   | Active    | 877635    | 789456         | 1:b                |
      # match all filter fields
      | VIN_TC145365_4  | 1698692000   | Active    | 877634    | 789456         | 1:b                |
      # match all filter fields
      | VIN_TC145365_5  | 1698692000   | Active    | 877634    | 789456         | 1:b                |
      # Not match vehicle model ID
      | VIN_TC145365_6  | 1698682000   | Active    | 877634    | 789457         |                    |
      # Not match specific attribute
      | VIN_TC145365_7  | 1698682000   | Active    | 877634    | 789456         |  1:a               |
      # Not match vin
      | VIN_TC145365_8 | 1698682000   | Active     | 877634    | 789456         |                    |
    And vehicle sends updated sw inventory for used ecus via API:
      | vin              | scomoId | version | nodeAddress | partNumber |
      | VIN_TC145365_1   | SCOMO1  | 2.0     |  MOST1234   | 0001-1234  |
      | VIN_TC145365_2   | SCOMO1  | 2.0     |  MosT1234   | 0001-1234  |
      | VIN_TC145365_3   | SCOMO1  | 2.0     |  MOsT1234   | 0001-5678  |
      | VIN_TC145365_4   | SCOMO1  | 2.0     |  MOST1234   | AbcD-5678  |
      | VIN_TC145365_5   | SCOMO1  | 2.0     |  MOsT5678   | 0001-1234  |
      | VIN_TC145365_6   | SCOMO6  | 2.0     |             |            |
      | VIN_TC145365_7   | SCOMO7  | 2.0     |             |            |
      | VIN_TC145365_8   | SCOMO8  | 2.0     |             |            |
    When get used ecus according to filter:
      | vin                 |  exactVins                                                                  | creationTime  | domainId      | status  | vehicleModelId | specificAttributes |  ecuSerialNumber  | softwareList |
      | VIN_TC145365_[1-7]  |  VIN_TC145365_1,VIN_TC145365_2,VIN_TC145365_3,VIN_TC145365_4,VIN_TC145365_5 | 1698683000    | 877634,877635 | Active  | 789456         | 1:b                |  1111             | SCOMO1,2.0   |
    Then used ecus response is:
      | nodeAddress   | partNumber  |
      | most1234      | 0001-1234   |
      | most1234      | 0001-5678   |
      | most1234      | abcd-5678   |
      | most5678      | 0001-1234   |

  @TC145364
  Scenario: get used ecus by non-existing filter data
    When get used ecus according to filter:
      #non-existing vin
      | vin             |
      | VIN_TC145364_10 |
    Then used ecus response is:
      |        |        |

  @TC145373
  Scenario: get used ecus for filtered part number
    Given following vehicles exist on swm db:
      | vin             | creationTime | status    | domainIds | vehicleModelId |
      | VIN_TC145373_1  | 1698692000   | Active    | 877634    | 789456         |
      | VIN_TC145373_2  | 1698692000   | Active    | 877634    | 789456         |
      | VIN_TC145373_3  | 1698692000   | Active    | 877634    | 789456         |
      | VIN_TC145373_4  | 1698692000   | Active    | 877634    | 789456         |
      | VIN_TC145373_5  | 1698692000   | Active    | 877634    | 789456         |
    And vehicle sends updated sw inventory for used ecus via API:
      | vin              | scomoId | version | nodeAddress | partNumber |
      | VIN_TC145373_1   | SCOMO1  | 2.0     |  MOST2222   | [blank]    |
      | VIN_TC145373_2   | SCOMO1  | 2.0     |  MOST2222   |            |
      | VIN_TC145373_3   | SCOMO1  | 2.0     |  MOST2222   | aaaa-1234  |
      | VIN_TC145373_4   | SCOMO1  | 2.0     |  MOST2222   | AbcD-5678  |
      | VIN_TC145373_5   | SCOMO1  | 2.0     |  MOst2222   | abcd-5678  |
    When get used ecus according to filter:
      | vin                |
      | VIN_TC145373_[1-5] |
    Then used ecus response is:
      | nodeAddress   | partNumber  |
      | most2222      | [blank]     |
      | most2222      |             |
      | most2222      | aaaa-1234   |
      | most2222      | abcd-5678   |

  @TC146442_1
  Scenario: get vehicles count by filter
    Given following vehicles exist on swm db:
      | vin              | creationTime | status    | domainIds | vehicleModelId | specificAttributes |
      | VIN_TC146442_11  | 1698692000   | Active    | 877634    | 789456         | 1:b                |
      | VIN_TC146442_12  | 1698692000   | Active    | 877635    | 789456         | 1:b                |
    And vehicle sends updated sw inventory via API:
      | vin               | scomoId | version |
      | VIN_TC146442_11   | SCOMO1  | 2.0     |
      | VIN_TC146442_12   | SCOMO1  | 2.0     |
    When get 2 vehicle by account according to filter:
      | vin                  |  exactVins                       | creationTime  | domainId      | status  | vehicleModelId | specificAttributes |  ecuSerialNumber  | softwareList |
      | VIN_TC146442_1[1-2]  |  VIN_TC146442_11,VIN_TC146442_12 | 1698683000    | 877634,877635 | Active  | 789456         | 1:b                |  1111             | SCOMO1,2.0   |

  @TC146442_2 @Negative
  Scenario: get 0 vehicles count by filter
    Given following vehicles exist on swm db:
      | vin             | creationTime | status    | domainIds | vehicleModelId | specificAttributes |
      | VIN_TC146442_2  | 1698692000   | Active    | 877634    | 789456         | 1:b                |
    And vehicle sends updated sw inventory via API:
      | vin              | scomoId | version |
      | VIN_TC146442_2   | SCOMO1  | 2.0     |
    When get 0 vehicle by account according to filter:
      | vin            |  exactVins      | creationTime  | domainId      | status  | vehicleModelId | specificAttributes |  ecuSerialNumber  | softwareList |
      | VIN_TC146442_3 |  VIN_TC146442_2 | 1698683000    | 877634,877635 | Active  | 789456         | 1:b                |  1111             | SCOMO1,2.0   |
