
    load('/Library/Ruby/Gems/2.6.0/gems/cfhighlander-0.11.1/lib/../cfndsl_ext/iam_helper.rb')

    load('/Library/Ruby/Gems/2.6.0/gems/cfhighlander-0.11.1/lib/../cfndsl_ext/lambda_helper.rb')

CloudFormation do
  # cfhl meta: cfndsl_version=1.0.5
  api_name = external_parameters.fetch(:api_name, nil)
  protocol_type = external_parameters.fetch(:protocol_type, nil)
  integration_type = external_parameters.fetch(:integration_type, nil)
  integration_uri = external_parameters.fetch(:integration_uri, nil)
  payload_version = external_parameters.fetch(:payload_version, nil)
  stage_name = external_parameters.fetch(:stage_name, nil)
  route_key = external_parameters.fetch(:route_key, nil)
  component_version = external_parameters.fetch(:component_version, nil)
  component_name = external_parameters.fetch(:component_name, nil)
  template_name = external_parameters.fetch(:template_name, nil)
  template_version = external_parameters.fetch(:template_version, nil)
  description = external_parameters.fetch(:description, nil)

  # render subcomponents


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
	



    # cfhighlander generated lambda functions
    

    # cfhighlander generated parameters

    Parameter('EnvironmentName') do
      Type 'String'
      Default 'dev'
      NoEcho false
    end

    Parameter('EnvironmentType') do
      Type 'String'
      Default 'development'
      NoEcho false
      AllowedValues ["development", "production"]
    end



    Description 'apigatewayv2 - latest'

    Output('CfTemplateUrl') {
        Value("https://580440732180.ap-southeast-2.cfhighlander.templates.s3.amazonaws.com/published-templates/apigatewayv2/latest/apigatewayv2.compiled.yaml")
    }
    Output('CfTemplateVersion') {
        Value("latest")
    }
end
