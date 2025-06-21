@VD @Contract

Feature: Contract VDI Signing Response

  @TC150165-01
  Scenario: VDI Signing - Contract - valid response
    When receive verification response from Singing "verificationResponseMessage.json"
    * wait 1 sec for inventory to be merged
    Then log contains the following info: "signature verification successfully verified"

  @TC150165-02
  Scenario: VDI Signing - Contract - response missing contentId
    When receive verification response from Singing "missingMandatoryContentId.json"
    * wait 1 sec for inventory to be merged
    Then log contains the following error: "The verification response message parameter \"contentId\" is mandatory"

  @TC150165-03
  Scenario: VDI Signing - Contract - response empty contentId
    When receive verification response from Singing "emptyMandatoryContentId.json"
    * wait 1 sec for inventory to be merged
    Then log contains the following error: "The verification response message parameter \"contentId\" is mandatory"

  @TC150165-04
  Scenario: VDI Signing - Contract - response empty message
    When receive verification response from Singing "emptyMessage.json"
    * wait 1 sec for inventory to be merged
    Then log contains the following error: "JSON object is not valid"

  @TC150165-05
  Scenario: VDI Signing - Contract - response message with errors
    When receive verification response from Singing "verificationResponseWithErrors.json"
    * wait 1 sec for inventory to be merged
    Then log contains the following error: "Verification response message parsing failed"

  @TC150165-06
  Scenario: VDI Signing - Contract - response missing result and errors
    When receive verification response from Singing "missingResultAndErrors.json"
    * wait 1 sec for inventory to be merged
    Then log contains the following error: "Verification response message parsing failed"
    Then log contains the following error: "One and only one of the given properties has to be not blank/empty"