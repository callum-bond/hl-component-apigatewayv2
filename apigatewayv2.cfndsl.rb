CloudFormation do
  Resource('Api') do
    Type('AWS::ApiGatewayV2::Api')
    Property('Name', api_name)
    Property('ProtocolType', protocol_type)
  end

  # Stage test does not exist. StageName specified on a CreateDeployment request must exist 
  # so the stage can be updated with the new deployment.
  Resource('Deployment') do 
    Type('AWS::ApiGatewayV2::Deployment')
    Property('ApiId', Ref('Api'))
    # Property('StageName', deployment_stagename)
  end

  # PayloadFormatVersion is a required parameter for integration 
  Resource('Integration') do 
    Type('AWS::ApiGatewayV2::Integration')
    Property('ApiId', Ref('Api')) 
    Property('IntegrationType', integration_type)
    Property('IntegrationUri', integration_uri)
    Property('PayloadFormatVersion', payload_version)
  end 
  
  Resource('Stage') do 
    Type('AWS::ApiGatewayV2::Stage')
    Property('ApiId', Ref('Api'))
    Property('StageName', stage_name)
  end
  
  #The provided route key is not formatted properly for HTTP protocol. 
  # Format should be "<HTTP METHOD> /<RESOURCE PATH>" or "$default"
  Resource('Route') do 
    Type('AWS::ApiGatewayV2::Route')
    Property('ApiId', Ref('Api'))
    Property('RouteKey', 'ANY /path')
  end
end


