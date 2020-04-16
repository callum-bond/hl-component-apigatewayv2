CloudFormation do
  Resource('Api') do
    Type('AWS::ApiGatewayV2::Api')
    Property('Name', api_name)
    Property('ProtocolType', protocol_type)
  end

  Resource('Deployment') do 
    DependsOn('Route')
    Type('AWS::ApiGatewayV2::Deployment')
    Property('ApiId', Ref('Api'))
    # Property('StageName', deployment_stagename)
  end

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
    Property('DeploymentId', Ref('Deployment'))
  end
  
  Resource('Route') do 
    Type('AWS::ApiGatewayV2::Route')
    Property('ApiId', Ref('Api'))
    Property('RouteKey', route_key)
    Property('Target', FnJoin('/', ["integrations", Ref('Integration')]))
  end
end
