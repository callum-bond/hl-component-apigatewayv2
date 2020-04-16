CfhighlanderTemplate do
  Name 'apigatewayv2'
  Description "apigatewayv2 - #{component_version}"

  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', allowedValues: ['development','production'], isGlobal: true
  end
end
