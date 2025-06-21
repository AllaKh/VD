@VD
Feature: Vehicle Data Signing Verification

  Background:
    Given all MS return valid responses

  @TC150166
  Scenario: Signature VDI - Success verification (delete the right VDI from DB)

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC147655_1 |
    When set use signature configuration to true
    When save dummy VDI request in database
    When vehicle sends inventory update via MQTT:
      | vin            | requestSource | useSignature |
      | VIN_TC147655_1 | VEHICLE       | true         |
    * wait 1 sec for inventory to be merged
    And only dummy VDI request exist in database
    Then Vehicle inventory for "VIN_TC147655_1" was updated

  @TC150167
  Scenario: Signature VDI - Failed verification

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC147656_1 |
    When set use signature configuration to true
    When Signing MS returns failed signature verification response
    When vehicle sends inventory update via MQTT:
      | vin            | requestSource | useSignature |
      | VIN_TC147656_1 | VEHICLE       | true         |
    * wait 1 sec for inventory to be merged
    Then Vehicle inventory for "VIN_TC147656_1" was not updated
    Then log contains the following error: "The Verification failed due to result : false in the message of the VDI verification."
    And security log contains the following error: "The Verification failed due to result : false in the message of the VDI verification."

  @TC150168
  Scenario: Signature VDI - Invalid verification

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC147657_1 |
    When set use signature configuration to true
    When Signing MS returns error signature verification response
    When vehicle sends inventory update via MQTT:
      | vin            | requestSource | useSignature |
      | VIN_TC147657_1 | VEHICLE       | true         |
    * wait 1 sec for inventory to be merged
    Then Vehicle inventory for "VIN_TC147657_1" was not updated
    Then log contains the following error: "The Verification failed due to errors : [SigningErrorDTO(code=message, message=message)] in the message of the VDI verification."
    And  security log contains the following error: "The Verification failed due to errors : [SigningErrorDTO(code=message, message=message)] in the message of the VDI verification."

  @TC150169
  Scenario: Signature VDI - Signature verification timeout

    When save dummy VDI request in database
    Then no dummy VDI request in database, after signature verification timeout

  @TC150170
  Scenario: Signature VDI - Use signature false - No VDI signature

    Given following vehicles exist on swm db:
      | vin            |
      | VIN_TC147927_1 |
    When set use signature configuration to false
    When vehicle sends inventory update via MQTT:
      | vin            | requestSource | useSignature |
      | VIN_TC147927_1 | VEHICLE       | false        |
    * wait 1 sec for inventory to be merged
    Then Vehicle inventory for "VIN_TC147927_1" was updated

