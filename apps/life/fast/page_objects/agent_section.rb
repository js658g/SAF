class AgentRow < SitePrism::Section

  element :agentContractColumn, :xpath, './/div[contains(@class,"x-grid3-col-Contract")]'
  element :agentContractEdit, :xpath, './/div[@class="'"x-layer x-editor x-small-editor x-grid-editor"'"]/input'

end

class AgentSection < SitePrism::Section

  element :agentNewButton, :xpath, './/table[@id="AGENT_ADD"]/tbody/tr/td/em/button[@class=" x-btn-text add"]'
  element :agentActive1, :xpath, './/div[contains(@class,"x-grid3-dirty-row")]'\
                                '/table/tbody/tr/td'\
                                '/div[contains(@class,"x-grid3-col-WarningMsg")]'\
                                '/img[contains(@src,"active")]'
  # section :agentInfoSection, AgentSection, :xpath, "//table[@id = 'AGENT_ADD']/../../../../../../../../../../.."
  section :row_1, AgentRow, :xpath, './/div[contains(@class, "x-grid3-row")][1]'
  section :row_2, AgentRow, :xpath, './/div[contains(@class, "x-grid3-row")][2]'

end