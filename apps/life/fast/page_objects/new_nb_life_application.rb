require 'site_prism'
require 'pry'
require 'capybara'

module PageObjects
  ##
  # New Business Life Application
  #   Inherits SitePrism::Page to show that this is a page
  class NbLifeApplication < SitePrism::Page
    set_url_matcher %r{index}

    # check that the header has loaded section headings
#    load_validation { [has_lifeAppHeader?, 'ERROR:NbLifeApplication: lifeAppHeader not found'] }
#    load_validation { [has_appInfoSection?, 'ERROR:NbLifeApplication: appInfoSection not found'] }
#    load_validation { [has_appSignedDatedSection?, 'ERROR:NbLifeApplication: appSignedDatedSection not found'] }
#    load_validation { [has_tempLifeAgreeSection?, 'ERROR:NbLifeApplication: tempLifeAgreeSection not found'] }
#    load_validation { [has_agentInfoSection?, 'ERROR:NbLifeApplication: agentInfoSection not found'] }
#    load_validation { [has_primaryInsInfoSection?, 'ERROR:NbLifeApplication: primaryInsInfoSection not found'] }
#    load_validation { [has_planInfoSection?, 'ERROR:NbLifeApplication: planInfoSection not found'] }
#    load_validation { [has_addlInsInfoSection?, 'ERROR:NbLifeApplication: addlInsInfoSection not found'] }
#    load_validation { [has_ownerInfoSection?, 'ERROR:NbLifeApplication: ownerInfoSection not found'] }
#    load_validation { [has_jointOwnerInfoSection?, 'ERROR:NbLifeApplication: jointOwnerInfoSection not found'] }
#    load_validation { [has_contingentOwnerInfoSection?, 'ERROR:NbLifeApplication: contingentOwnerInfoSection not found'] }
#    load_validation { [has_payorInfoSection?, 'ERROR:NbLifeApplication: payorInfoSection not found'] }
#    load_validation { [has_childInfoSection?, 'ERROR:NbLifeApplication: childInfoSection not found'] }
#    load_validation { [has_benInfoPersonSection?, 'ERROR:NbLifeApplication: benInfoPersonSection not found'] }
#    load_validation { [has_benInfoOrgSection?, 'ERROR:NbLifeApplication: benInfoOrgSection not found'] }
#    load_validation { [has_benefitInfoSection?, 'ERROR:NbLifeApplication: benefitInfoSection not found'] }
#    load_validation { [has_riderInfoSection?, 'ERROR:NbLifeApplication: riderInfoSection not found'] }
#    load_validation { [has_existCovReplInfoSection?, 'ERROR:NbLifeApplication: existCovReplInfoSection not found'] }
#    load_validation { [has_paymentOptionsSection?, 'ERROR:NbLifeApplication: paymentOptionsSection not found'] }
#    load_validation { [has_premiumDetailsSection?, 'ERROR:NbLifeApplication: premiumDetailsSection not found'] }
#    load_validation { [has_groupBillingDetailsSection?, 'ERROR:NbLifeApplication: groupBillingDetailsSection not found'] }
#    load_validation { [has_indexOptionsSection?, 'ERROR:NbLifeApplication: indexOptionsSection not found'] }
#    load_validation { [has_formsSection?, 'ERROR:NbLifeApplication: formsSection not found'] }
    load_validation do
      wait_until_loading_pane_invisible
      true
    end

    element :loading_pane, :xpath, "//div[@class='x-progress-inner']"
      
    # TODO: refactor to make Menu navigation and header navigation as sections
    # known to every FAST page
    element :lifeAppHeader, 'div[class="f8x-page-content-center-page"]', text: 'Life Application'

    element :appInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                      "[not(contains(@style, 'hidden'))]"\
                                      "/div[contains(.,'Application Information')]"
    element :appSignedDatedSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Application Signed and Dated')]"
    element :tempLifeAgreeSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Temporary Life Insurance Agreement')]"
    element :agentInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Agent Information')]"
    element :primaryInsInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Primary Insured Information')]"
    element :planInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Plan Information')]"
    element :addlInsInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Additional Insured Information')]"
    element :ownerInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Owner Information')]"
    element :jointOwnerInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Joint Owner Information')]"
    element :contingentOwnerInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Contingent Owner Information')]"
    element :payorInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Payor Information')]"
    element :childInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Child Information')]"
    element :benInfoPersonSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Beneficiary Information - Person')]"
    element :benInfoOrgSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Beneficiary Information - Organization')]"
    element :benefitInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Benefit Information')]"
    element :riderInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Rider Information')]"
    element :existCovReplInfoSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Existing Coverage/Replacement')]"
    element :paymentOptionsSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Payment Options')]"
    element :premiumDetailsSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Premium Details')]"
    element :bankingDetailsSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Banking Details')]"
    element :groupBillingDetailsSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Group Billing Details')]"
    element :indexOptionsSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Index Options')]"
    element :formsSection, :xpath, "//div[contains(@class, 'x-tab-panel-body')]"\
                                             "[not(contains(@style, 'hidden'))]"\
                                             "/div[contains(.,'Forms')]"

    # appInfoSection
    element :polID, 'input[name="PolID"]'
    fast_drop_down_box :risk_area, 'RiskArea'
    element :appRcvdDate, 'input[name="AppDateReceived"]'
    element :membershipNo, 'input[name="MembershipNum"]'
    fast_drop_down_box :company, 'CompanyID'
    fast_drop_down_box :appType, 'AppType'
    fast_drop_down_box :appSource, 'AppSource'
    fast_drop_down_box :appStatus, 'AppStatus'

    # appSignedDatedSection
    element :appBackupWithholding, 'input[name="WithholdingRequiredInd"]'
    element :appSignCity, 'input[name="AppSignCity"]'
    fast_drop_down_box :appSignState, 'AppSignState'
    element :appSignDate, 'input[name="AppSignDate"]'

    # tempLifeAgreeSection
    element :tiaQuestion1, 'input[name="TIA90Days"]'
    element :tiaQuestion2, 'input[name="TIA2Years"]'

    # agentInfoSection

    section :agentInfoSection, AgentSection, :xpath, "//table[@id = 'AGENT_ADD']/../../../../../../../../../../.."
    # element :agentNewButton, :xpath, '//table[@id="AGENT_ADD"]/tbody/tr/td/em/button[@class=" x-btn-text add"]'
    # element :agentContractColumn, :xpath, '//div[contains(@class,"x-grid3-col-Contract")]'
    # element :agentContractEdit, :xpath, '//div[@class="'"x-layer x-editor x-small-editor x-grid-editor"'"]/input'
    # element :agentActive1, :xpath, '//div[contains(@class,"x-grid3-dirty-row")]'\
    #                             '/table/tbody/tr/td'\
    #                             '/div[contains(@class,"x-grid3-col-WarningMsg")]'\
    #                             '/img[contains(@src,"active")]'
    #
    # # primaryInsInfoSection
    # element :first_name, 'input[name="PrimInsFirstName"]'
    # element :middle_name, 'input[name="PrimInsMiddleName"]'
    # element :last_name, 'input[name="PrimInsLastName"]'
    # fast_drop_down_box :name_suffix, "PrimInsSuffix"
    # fast_drop_down_box :gender, "PrimInsGender"
    # element :birth_date, 'input[name="PrimInsBirthDate"]'
    # element :age, 'input[name="PrimInsAge"]'
    # fast_drop_down_box :birth_country, "PrimInsBirthCountry"
    # fast_drop_down_box :birth_state, "PrimInsBirthState"
    # element :address_line_1, 'input[name="PrimInsLine1"]'
    # element :address_line_2, 'input[name="PrimInsLine2"]'
    # element :address_line_3, 'input[name="PrimInsLine3"]'
    # element :city, 'input[name="PrimInsCity"]'
    # fast_drop_down_box :country, "PrimInsCountry"
    # fast_drop_down_box :state, "PrimInsState"
    # element :zip_code, 'input[name="PrimInsZip"]'
    # element :zip_ext, 'input[name="PrimInsZipPlusFour"]'
    # fast_drop_down_box :govt_id_type, "PrimInsGovtIDTC"
    # element :social_security_number, 'input[name="PrimInsGovtID"]'
    # element :drivers_license_number, 'input[name="PrimInsDriversLicenseNum"]'
    # fast_drop_down_box :drivers_license_state, "PrimInsDriversLicenseState"
    # element :cell_phone, 'input[name="CellPhoneNo"]'
    # element :occupation, 'input[name="Occupation"]'
    # element :income, 'input[name="Income"]'
    # element :net_worth, 'input[name="Networth"]'
    # element :home_phone, 'input[name="PrimInsHomePhone"]'
    # element :business_phone, 'input[name="PrimInsBusinessPhone"]'
    # element :email, 'input[name="PrimInsEmailAddress"]'
    # fast_drop_down_box :preferred_language, "PrimInsPrefLanguage"
    # fast_drop_down_box :smoker_status, "PrimInsSmokerStatus"

    # planInfoSection
    element :totalFaceAmount, 'input[name="PrimInsTotalFaceAmount"]'
    element :conversionGIOAmount, 'input[name="PrimInsConvGIOAmount"]'
    element :premium, 'input[name="PrimInsPremium"]'
    fast_drop_down_box :planName, 'PrimInsPlanName'
    element :issueDate, 'input[name="AppDateIssued"]'
    fast_drop_down_box :coverageType, 'ProductOption'
    fast_drop_down_box :premiumPeriod, 'PremPeriodOption'
    fast_drop_down_box :dividendOption, 'DividendOption'
    fast_drop_down_box :nonforfeitureOption, 'NFOOption'
    fast_drop_down_box :deathBenefitOption, 'DeathBenefitOption'
    fast_drop_down_box :qualificationTest, 'QualificationTest'
    element :otherLifeOrAnnuity, 'input[name="PolReplacementFlag"]'
    element :existingInsurerName, 'input[name="ExistingInsurerName"]'
    element :existingPolicyNum, 'input[name="existingPolicyNum"]'
    element :policyMailing, 'input[name="PolicyMailing"]'

    # ownerInfoSection
    # fast_drop_down_box :owner_party_type, "OwnerPartyType"
    # fast_drop_down_box :owner_org_type, "OwnerOrgType"
    # element :owner_org_name, 'input[name="OwnerOrgName"]'
    # element :owner_first_name, 'input[name="OwnerFirstName"]'
    # element :owner_middle_name, 'input[name="OwnerMiddleName"]'
    # element :owner_last_name, 'input[name="OwnerLastName"]'
    # fast_drop_down_box :owner_suffix, "OwnerSuffix"
    # element :owner_address_line_1, 'input[name="OwnerLine1"]'
    # element :owner_address_line_2, 'input[name="OwnerLine2"]'
    # element :owner_address_line_3, 'input[name="OwnerLine3"]'
    # element :owner_city, 'input[name="OwnerCity"]'
    # fast_drop_down_box :owner_state, "OwnerState"
    # element :owner_zip_code, 'input[name="OwnerZip"]'
    # element :owner_zip_ext, 'input[name="OwnerZipPlusFour"]'
    # fast_drop_down_box :owner_birth_country, "OwnerBirthCountry"
    # fast_drop_down_box :owner_gender, "OwnerGender"
    # element :owner_birth_date, 'input[name="OwnerBirthDate"]'
    # element :owner_age, 'input[name="OwnerAge"]'
    # element :owner_home_phone, 'input[name="OwnerHomePhone"]'
    # element :owner_cell_phone, 'input[name="OwnerCellPhone"]'
    # fast_drop_down_box :owner_govt_id_type, "OwnerGovtIDTC"
    # element :owner_ssn, 'input[name="OwnerSSN"]'
    # element :owner_trust_date, 'input[name="OwnerTrustDate"]'
    # element :owner_sign_date, 'input[name="OwnerSignDate"]'
    # TODO: add other sections

    # action for web page form

    # The following method waits for the combo boxes to load by checking if the app signed city loaded..
    def app_sign_city_wait
      wait_for_appSignCity
      puts 'ERROR:NbLifeApplication: new life app elements not visible' unless (has_appSignCity? && appSignCity.visible?)
    end

    def fill_application(test_data)
      # TODO: add code for generating policy ID
      polID.set test_data['file_number'] unless
          (test_data['file_number'].nil? || test_data['file_number'] == '')
      # wait_for_risk_area #throws undefined method error..as this is not element..its our fast drop down box component
      risk_area.select(test_data['risk_area']) unless
          (test_data['risk_area'].nil? || test_data['risk_area'] == '')
      if test_data['appl_date_recv'].nil? || test_data['appl_date_recv'] == ''
        today = Date.today.strftime('%m/%d/%Y')
        fill_in(appRcvdDate, with: today)
      else
        fill_in(appRcvdDate, with: test_data['appl_date_recv'])
      end
      if test_data['membership_number'].nil? || test_data['membership_number'] == ''
        fill_in(membershipNo, with: '0')
      else
        fill_in(membershipNo, with: test_data['membership_number'])
      end
      # TODO: what to do when it finds two because it is already set?
      company.select(test_data['company']) unless
          (test_data['company'].nil? || test_data['company'] == '')
      appType.select(test_data['appl_type']) unless
          (test_data['appl_type'].nil? || test_data['appl_type'] == '')
      appSource.select(test_data['appl_source']) unless
          (test_data['appl_source'].nil? || test_data['appl_source'] == '')
      appStatus.select(test_data['appl_status']) unless
          (test_data['appl_status'].nil? || test_data['appl_status'] == '')
      if test_data['appl_backup_withholding']
        input = test_data['appl_backup_withholding'].downcase
        if input == 'check' || input == 'y' || input == 'yes' || input == 'true'
          appl_backup_withholding.set(true) unless appl_backup_withholding.checked?
        elsif input == 'uncheck' || input == 'n' || input == 'no' || input == 'false'
          appl_backup_withholding.set(false) if appl_backup_withholding.checked?
        end
      end
      fill_in(appSignCity, with: test_data['appl_city']) unless
          (test_data['appl_city'].nil? || test_data['appl_city'] == '')
      appSignState.select (test_data['appl_state_signed']) unless
          (test_data['appl_state_signed'].nil? || test_data['appl_state_signed'] == '')
      if test_data['appl_date_signed'].nil? || test_data['appl_date_signed'] == ''
        today = Date.today.strftime('%m/%d/%Y')
        fill_in(appSignDate, with: today)
      else
        fill_in(appSignDate, with: test_data['appl_date_signed'])
      end
      if test_data['tiaQuestion1']
        input = test_data['tiaQuestion1'].downcase
        if input == 'check' || input == 'y' || input == 'yes' || input == 'true'
          tiaQuestion1.set(true) unless tiaQuestion1.checked?
        elsif input == 'uncheck' || input == 'n' || input == 'no' || input == 'false'
          tiaQuestion1.set(false) if tiaQuestion1.checked?
        end
      end
      if test_data['tiaQuestion2']
        input = test_data['tiaQuestion2'].downcase
        if input == 'check' || input == 'y' || input == 'yes' || input == 'true'
          tiaQuestion2.set(true) unless tiaQuestion2.checked?
        elsif input == 'uncheck' || input == 'n' || input == 'no' || input == 'false'
          tiaQuestion2.set(false) if tiaQuestion2.checked?
        end
      end
    end

    def fill_plan(test_data)
      fill_in(totalFaceAmount, with: test_data['total_face_amount']) unless
        (test_data['total_face_amount'].nil? || test_data['total_face_amount'] == '')
      fill_in(conversionGIOAmount, with: test_data['conversion_GIO_amount']) unless
        (test_data['conversion_GIO_amount'].nil? || test_data['conversion_GIO_amount'] == '')
      fill_in(premium, with: test_data['premium']) unless
        (test_data['premium'].nil? || test_data['premium'] == '')
      planName.select(test_data['plan_name']) unless
        (test_data['plan_name'].nil? || test_data['plan_name'] == '')
      if test_data['issue_date'].nil? || test_data['issue_date'] == ''
        today = Date.today.strftime('%m/%d/%Y')
        fill_in(issueDate, with: today)
      else
        fill_in(issueDate, with: test_data['issue_date'])
      end
      # coverageType javascript is dependent on a valid issueDate already filled in,
      # without it, the javascript will not return any selection in drop down
      coverageType.select(test_data['coverage_type']) unless
        (test_data['coverage_type'].nil? || test_data['coverage_type'] == '')
      premiumPeriod.select(test_data['premium_period']) unless
        (test_data['premium_period'].nil? || test_data['premium_period'] == '')
      dividendOption.select(test_data['dividend_option']) unless
        (test_data['dividend_option'].nil? || test_data['dividend_option'] == '')
      nonforfeitureOption.select(test_data['nonforfeiture_option']) unless
        (test_data['nonforfeiture_option'].nil? || test_data['nonforfeiture_option'] == '')
      deathBenefitOption.select(test_data['death_benefit_option']) unless
        (test_data['death_benefit_option'].nil? || test_data['death_benefit_option'] == '')
      qualificationTest.select(test_data['qualification_test']) unless
        (test_data['qualification_test'].nil? || test_data['qualification_test'] == '')
      if test_data['otherLifeOrAnnuity']
        input = test_data['otherLifeOrAnnuity'].downcase
        if input == 'check' || input == 'y' || input == 'yes' || input == 'true'
          otherLifeOrAnnuity.set(true) unless otherLifeOrAnnuity.checked?
        elsif input == 'uncheck' || input == 'n' || input == 'no' || input == 'false'
          otherLifeOrAnnuity.set(false) if otherLifeOrAnnuity.checked?
        end
      end
      fill_in(existingInsurerName, with: test_data['existing_insurer_name']) unless
        (test_data['existing_insurer_name'].nil? || test_data['existing_insurer_name'] == '')
      fill_in(existingPolicyNum, with: test_data['existing_policy_number']) unless
        (test_data['existing_policy_number'].nil? || test_data['existing_policy_number'] == '')
      fill_in(policyMailing, with: test_data['policy_mailing']) unless
        (test_data['policy_mailing'].nil? || test_data['policy_mailing'] == '')
    end

    def fill_agent(test_data)
      # binding.pry
      if test_data['contract']
        contractInput = test_data['contract']
        # click New button to add a contract number for agent
        # agentNewButton.send_keys(nil)
        # agentNewButton.click
        agentInfoSection.agentNewButton.send_keys(nil)
        agentInfoSection.agentNewButton.click

        # double click on row to get input field
        # agentContractColumn.double_click
        # wait_for_agentContractEdit
        # if agentContractEdit.text == ''
        # agentContractColumn.double_click
        # wait_for_agentContractEdit
        # if agentContractEdit.text == ''

        agentInfoSection.row_1.agentContractColumn.double_click

        agentInfoSection.row_1.wait_for_agentContractEdit

        if agentInfoSection.row_1.agentContractEdit.text == ''
          # enter contract number into input field
          agentContractEdit.set(contractInput)
          agentInfoSection.row_1.agentContractEdit.send_keys(contractInput)
          # tab to next field will trigger javascript to retrieve agent information
          agentContractEdit.send_keys(:tab)
          agentInfoSection.row_1.agentContractEdit.send_keys(:tab)
        else
          # TODO: if already has agent, need to refactor code to add new row
        end
        binding.pry
        agentInfoSection.agentNewButton.send_keys(nil)
        agentInfoSection.agentNewButton.click

        # double click on row to get input field

        agentInfoSection.row_2.agentContractColumn.double_click

        agentInfoSection.row_2.wait_for_agentContractEdit

        if agentInfoSection.row_2.agentContractEdit.text == ''
          # enter contract number into input field
          agentInfoSection.row_2.agentContractEdit.send_keys(contractInput)
          # tab to next field will trigger javascript to retrieve agent information
          agentInfoSection.row_2.agentContractEdit.send_keys(:tab)
        else
          # TODO: if already has agent, need to refactor code to add new row
        end

        # TODO: temporary wait for fetch of agent information to return,
        # should really be for current row where our contract number was entered
        wait_for_agentActive1

      end
    end

    def verify_all_agent_info
      # TODO: find current row of contract entered, check that img src is active.png else
      # we didn't get valid agent back, do error handling.
      # verify that all information present in test_data agent fields matches
      # those returned on web page
    end
  end
end


