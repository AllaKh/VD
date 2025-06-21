@VD
Feature: vehicles software filter

  @TC144567-1
  Scenario Outline: vehicles software filter - <vin> <accountIdsRequest> <matchingAccountIdsRequest> <scomoIdAndVersionRegexRequest> <response>
    Given following vehicles exist on swm db:
      | vin                  | domainIds |
      | VIN_TC144567_1.<vin> |  111111   |
      | VIN_TC144567_2.<vin> |  111112   |
      | VIN_TC144567_3.<vin> |  111113   |
    And vehicle sends updated sw inventory via API:
      | vin                  | sequence | inventoryType | scomoId | version |
      | VIN_TC144567_1.<vin> | 1        | SW_FULL       | SCOMO1  | 2.0     |
      | VIN_TC144567_2.<vin> | 1        | SW_FULL       | SCOMO2  | 2.0     |
      | VIN_TC144567_3.<vin> | 1        | SW_FULL       | SCOMO3  | 2.0     |
      | VIN_TC144567_3.<vin> | 2        | SW_PARTIAL    | SCOMO4  | 3.0     |
    When get 10 vehicles software filter
      | accountIds          | matchingAccountIds          | scomoIdAndVersionRegex           |
      | <accountIdsRequest> | <matchingAccountIdsRequest> |  <scomoIdAndVersionRegexRequest> |
    Then <response> vehicles software are returned

    Examples:
      | vin  | accountIdsRequest     | matchingAccountIdsRequest | scomoIdAndVersionRegexRequest |       response                                                          |
      |  1   | 111111,111112,111113  |  111114                   | SCOMO*                        | 111111,SCOMO1,2.0;111112,SCOMO2,2.0;111113,SCOMO3,2.0;111113,SCOMO4,3.0 |
      |  2   | 111111,111112,111113  |  111111,111112            | non                           | 111111,SCOMO1,2.0;111112,SCOMO2,2.0                                     |
      |  3   | 111111,111112,111113  |  111113                   | SCOMO4                        | 111113,SCOMO3,2.0;111113,SCOMO4,3.0                                     |
      |  4   | 111111,111112,111113  |                           |                               | 111111,SCOMO1,2.0;111112,SCOMO2,2.0;111113,SCOMO3,2.0;111113,SCOMO4,3.0 |
      |  5   | 111111,111112,111113  |  111111                   | [blank]                       | 111111,SCOMO1,2.0                                                       |
      |  6   | 111111,111112,111113  |  [blank]                  | SCOMO4                        | 111113,SCOMO4,3.0                                                       |
      |  7   | 111111,111112,111113  |  222222                   | non                           |                                                                         |
      |  8   | 111111,111112,111113  |  [blank]                  | [blank]                       |                                                                         |


  @TC144567-2
  Scenario: vehicles software filter over size limit
    Given following vehicles exist on swm db:
      | vin                  | domainIds |
      | VIN_TC144567_2       |  111111   |
    And vehicle sends updated sw inventory via API:
      | vin             | scomoId | version |
      | VIN_TC144567_2  | SCOMO1  | 1.0     |
    When get error for 10001 vehicles software filter request
    Then proper response is returned:
      | Status | Code             | Message                                             |
      | 400    | vd.invalid.input | getVehiclesSoftwareFilter.size: Size range: 1-10000 |